import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/chad_progress_provider.dart';
import 'providers/workout_provider.dart';
import 'screens/home_screen.dart';
import 'screens/workout_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/settings_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const GigaChadRunnerApp());
}

class GigaChadRunnerApp extends StatelessWidget {
  const GigaChadRunnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChadProgressProvider()),
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
      ],
      child: MaterialApp(
        title: 'GigaChad Runner',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.appBarBackground,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.chadGold),
            titleTextStyle: TextStyle(
              color: AppColors.chadGold,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: AppColors.charcoalBlack,
            selectedItemColor: AppColors.selectedItem,
            unselectedItemColor: AppColors.unselectedItem,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              color: AppColors.chadGold,
              fontWeight: FontWeight.bold,
            ),
          ),
          cardTheme: CardThemeData(
            color: AppColors.cardBackground,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: AppColors.borderGold, width: 1),
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WorkoutScreen(),
    const ProgressScreen(),
    const StatsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: '운동',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: '진행률'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '통계'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }
}
