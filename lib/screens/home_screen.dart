import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/chad_progress_provider.dart';
import '../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GIGACHAD RUNNER',
          style: GoogleFonts.bebasNeue(fontSize: 28, color: AppColors.chadGold),
        ),
        centerTitle: true,
      ),
      body: Consumer<ChadProgressProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Chad 이미지
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderGold, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.chadGold.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.asset(
                      provider.getCurrentChadImage(),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.cardBackground,
                          child: Icon(
                            Icons.person,
                            size: 120,
                            color: AppColors.chadGold,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Chad 레벨
                Text(
                  provider.getChadLevel(),
                  style: GoogleFonts.bebasNeue(
                    fontSize: 36,
                    color: AppColors.textPrimary,
                    shadows: [Shadow(color: AppColors.chadGold, blurRadius: 8)],
                  ),
                ),

                const SizedBox(height: 10),

                // Chad 메시지
                Text(
                  provider.getChadMessage(),
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 20,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 30),

                // 일일 목표 진행률
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.borderGold, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.chadGold.withValues(alpha: 0.1),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Day ${provider.currentDay} Progress',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 24,
                          color: AppColors.chadGold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      LinearProgressIndicator(
                        value: provider.dailyProgress / 100,
                        backgroundColor: AppColors.charcoalBlack,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.chadGold,
                        ),
                        minHeight: 12,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${provider.dailyProgress.toInt()}%',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 일일 명언
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.charcoalBlack,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.chadGoldDark.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    provider.getDailyQuote(),
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
