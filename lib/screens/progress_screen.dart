import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/chad_progress_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '진행률',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            color: const Color(0xFFFFD700),
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ChadProgressProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 현재 Chad 레벨
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFFFD700),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '현재 Chad 레벨',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        provider.getChadLevel(),
                        style: GoogleFonts.bebasNeue(
                          fontSize: 36,
                          color: const Color(0xFFFFD700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        provider.getChadMessage(),
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 일일 진행률
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
                        'Day ${provider.currentDay} 달성률',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 24,
                          color: const Color(0xFFFFD700),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF444444),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            height: 20,
                            width:
                                MediaQuery.of(context).size.width *
                                (provider.dailyProgress / 100) *
                                0.8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '${provider.dailyProgress.toInt()}% / 100%',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Chad 이미지 갤러리
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Chad Gallery',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 24,
                            color: const Color(0xFFFFD700),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: [
                              _buildChadImageTile('기본차드.jpg', 'Rookie Chad'),
                              _buildChadImageTile('눈빔차드.jpg', 'Rising Chad'),
                              _buildChadImageTile('커피차드.png', 'Alpha Chad'),
                              _buildChadImageTile('썬글차드.jpg', 'Sigma Chad'),
                              _buildChadImageTile('정면차드.jpg', 'Giga Chad'),
                              _buildChadImageTile('더블차드.jpg', 'Ultra Chad'),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildChadImageTile(String imageName, String levelName) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF444444), width: 1),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.asset(
                'assets/images/$imageName',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF1A1A1A),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFFFFD700),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Text(
              levelName,
              style: GoogleFonts.robotoCondensed(
                fontSize: 12,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
