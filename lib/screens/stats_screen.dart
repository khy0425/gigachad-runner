import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '통계',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            color: const Color(0xFFFFD700),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 주간 통계
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFFFD700), width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    '주간 통계',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: const Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('총 거리', '12.5km'),
                      _buildStatItem('총 시간', '2:15:30'),
                      _buildStatItem('평균 속도', '5.5km/h'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Chad 레벨 히스토리
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Chad Level Progress',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: const Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(6, (index) {
                    final levels = [
                      'Rookie Chad',
                      'Rising Chad',
                      'Alpha Chad',
                      'Sigma Chad',
                      'Giga Chad',
                      'Ultra Chad',
                    ];
                    final isUnlocked = index <= 1; // 예시로 2개만 해제

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUnlocked
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFF444444),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isUnlocked
                              ? const Color(0xFFFFD700)
                              : const Color(0xFF666666),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isUnlocked ? Icons.check_circle : Icons.lock,
                            color: isUnlocked
                                ? const Color(0xFFFFD700)
                                : const Color(0xFF666666),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            levels[index],
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 18,
                              color: isUnlocked ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 개인 기록
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    '개인 최고 기록',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: const Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRecordItem('최고 속도', '8.2km/h', '2024-12-15'),
                      _buildRecordItem('최장 거리', '5.2km', '2024-12-10'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // 마지막 여백 추가
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            color: const Color(0xFFFFD700),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.robotoCondensed(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildRecordItem(String label, String value, String date) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.bebasNeue(
            fontSize: 20,
            color: const Color(0xFFFFD700),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.robotoCondensed(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          date,
          style: GoogleFonts.robotoCondensed(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
