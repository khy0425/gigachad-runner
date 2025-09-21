import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _runReminders = true;
  bool _activayUpdates = true;
  bool _promotionalOffers = true;
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '설정',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            color: const Color(0xFFFFD700),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 프로필
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
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFFFD700),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'GigaChad Runner',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: const Color(0xFFFFD700),
                    ),
                  ),
                  Text(
                    'User Name',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 설정 섹션
            Text(
              'User Profile:',
              style: GoogleFonts.robotoCondensed(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 알림 설정
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications:',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Clickount Settings',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  _buildSettingRow(
                    'Run Reminders',
                    _runReminders,
                    (value) => setState(() => _runReminders = value),
                  ),

                  _buildSettingRow(
                    'Activay Updates',
                    _activayUpdates,
                    (value) => setState(() => _activayUpdates = value),
                  ),

                  _buildSettingRow(
                    'Promotional Offers',
                    _promotionalOffers,
                    (value) => setState(() => _promotionalOffers = value),
                  ),

                  _buildSettingRow(
                    'Promotional Offers',
                    _promotionalOffers,
                    (value) => setState(() => _promotionalOffers = value),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'About:',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 테마 설정
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  _buildSettingRow(
                    'Dark/Light Theme',
                    _darkMode,
                    (value) => setState(() => _darkMode = value),
                  ),

                  Row(
                    children: [
                      Text(
                        'Dark/Light',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.robotoCondensed(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.red,
            activeTrackColor: Colors.red.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
