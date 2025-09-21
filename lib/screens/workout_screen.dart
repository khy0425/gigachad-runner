import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../utils/app_colors.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '달리기',
          style: GoogleFonts.bebasNeue(fontSize: 28, color: AppColors.chadGold),
        ),
        centerTitle: true,
      ),
      body: Consumer<WorkoutProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 시간 표시
                Text(
                  provider.formattedTime,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 72,
                    color: AppColors.chadGold,
                    shadows: [
                      Shadow(
                        color: AppColors.chadGold.withValues(alpha: 0.5),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Chad 레벨 표시
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: provider.currentChadLevel.color,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: provider.currentChadLevel.color.withValues(
                          alpha: 0.3,
                        ),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    provider.currentChadLevel.name,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                      color: provider.currentChadLevel.color,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 통계
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard(
                      '거리',
                      '${provider.distance.toStringAsFixed(1)}km',
                    ),
                    _buildStatCard(
                      '속도',
                      '${provider.speed.toStringAsFixed(1)}km/h',
                    ),
                    _buildStatCard(
                      '페이스',
                      provider.seconds > 0
                          ? (provider.distance / (provider.seconds / 3600))
                                .toStringAsFixed(1)
                          : '0.0',
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // 시작/정지 버튼
                ElevatedButton(
                  onPressed: () async {
                    if (provider.isRunning) {
                      provider.stopWorkout();
                    } else {
                      final started = await provider.startWorkout();
                      if (!started) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('GPS를 켜주시거나 위치 권한을 허용해주세요!'),
                              backgroundColor: AppColors.cardBackground,
                            ),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.isRunning
                        ? AppColors.errorRed
                        : AppColors.chadGold,
                    foregroundColor: provider.isRunning
                        ? AppColors.textSecondary
                        : AppColors.textOnGold,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: provider.isRunning
                        ? AppColors.errorRed.withValues(alpha: 0.3)
                        : AppColors.chadGold.withValues(alpha: 0.3),
                  ),
                  child: Text(
                    provider.isRunning ? '정지' : '시작',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 리셋 버튼
                if (!provider.isRunning && provider.seconds > 0)
                  TextButton(
                    onPressed: provider.resetWorkout,
                    child: Text(
                      '리셋',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.borderGold.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.chadGold.withValues(alpha: 0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.robotoCondensed(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.bebasNeue(
              fontSize: 20,
              color: AppColors.chadGold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
