import 'package:flutter/material.dart';

class ChadProgressProvider with ChangeNotifier {
  final int _currentDay = 1;
  double _dailyProgress = 15.0;
  int _chadLevel = 1;

  double get dailyProgress => _dailyProgress;
  int get currentDay => _currentDay;

  String getCurrentChadImage() {
    if (_chadLevel <= 1) return 'assets/images/기본차드.jpg';
    if (_chadLevel <= 2) return 'assets/images/눈빔차드.jpg';
    if (_chadLevel <= 3) return 'assets/images/커피차드.png';
    if (_chadLevel <= 4) return 'assets/images/썬글차드.jpg';
    if (_chadLevel <= 5) return 'assets/images/정면차드.jpg';
    return 'assets/images/더블차드.jpg';
  }

  String getChadLevel() {
    if (_chadLevel <= 1) return 'Rookie Chad';
    if (_chadLevel <= 2) return 'Rising Chad';
    if (_chadLevel <= 3) return 'Alpha Chad';
    if (_chadLevel <= 4) return 'Sigma Chad';
    if (_chadLevel <= 5) return 'Giga Chad';
    return 'Ultra Chad';
  }

  String getChadMessage() {
    final messages = [
      '시작한다... Yes.',
      '집중한다... Yes.',
      '에너지... Yes.',
      '쿨하다... Yes.',
      '완벽하다... Yes.',
      '최강이다... Yes.',
    ];
    return messages[(_chadLevel - 1).clamp(0, messages.length - 1)];
  }

  String getDailyQuote() {
    final quotes = [
      '"약한 자는 복수를 꿈꾸고, 강한 자는 용서를 배운다. 하지만 기가차드는 그냥 달린다."',
      '"일어나라, 달려라, 정복하라. 기가차드는 멈추지 않는다."',
      '"고통은 임시적이다. 그러나 기가차드는 영원하다."',
      '"다른 사람들이 멈출 때, 기가차드는 시작한다."',
      '"불가능? 기가차드에게는 존재하지 않는 단어다."',
    ];
    return quotes[(_chadLevel - 1).clamp(0, quotes.length - 1)];
  }

  void updateProgress(double progress) {
    _dailyProgress = progress.clamp(0.0, 100.0);

    // Chad 레벨 업데이트
    if (_dailyProgress >= 100.0 && _chadLevel < 6) {
      _chadLevel++;
      _dailyProgress = 0.0; // 다음 레벨을 위해 리셋
    }

    notifyListeners();
  }

  void viewStats() {
    // Chad Stats: Level $_chadLevel, Progress: $_dailyProgress%
  }
}
