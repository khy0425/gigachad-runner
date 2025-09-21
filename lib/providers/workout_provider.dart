import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/workout_data.dart';
import '../models/chad_level.dart';
import '../services/gps_service.dart';
import '../services/vibration_service.dart';

class WorkoutProvider with ChangeNotifier {
  final GPSService _gpsService = GPSService();

  bool _isRunning = false;
  int _seconds = 0;
  double _distance = 0.0;
  double _speed = 0.0;
  ChadLevel _currentChadLevel = ChadLevel.levels[ChadLevelType.betaPace]!;
  Timer? _timer;

  // Getters
  bool get isRunning => _isRunning;
  int get seconds => _seconds;
  double get distance => _distance;
  double get speed => _speed;
  ChadLevel get currentChadLevel => _currentChadLevel;

  String get formattedTime {
    int hours = _seconds ~/ 3600;
    int minutes = (_seconds % 3600) ~/ 60;
    int secs = _seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<bool> startWorkout() async {
    final started = await _gpsService.startTracking(
      onPositionUpdate: _onPositionUpdate,
    );

    if (started) {
      _isRunning = true;
      _startTimer();
      await VibrationService.startVibration();
      notifyListeners();
      return true;
    }
    return false;
  }

  void stopWorkout() {
    _isRunning = false;
    _gpsService.stopTracking();
    _timer?.cancel();
    VibrationService.stopVibration();
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        _seconds++;
        notifyListeners();
      }
    });
  }

  void _onPositionUpdate(Position position) {
    if (!_isRunning) return;

    final previousPosition = _gpsService.previousPosition;
    if (previousPosition != null) {
      double newDistance = _gpsService.calculateDistance(
        previousPosition,
        position,
      );
      _distance += newDistance / 1000; // 미터를 킬로미터로 변환
    }

    // 속도 계산 (km/h)
    if (_seconds > 0) {
      _speed = _distance / (_seconds / 3600);
    }

    // Chad 레벨 판정
    _updateChadLevel();
    notifyListeners();
  }

  void _updateChadLevel() {
    double paceMinutesPerKm = _speed > 0 ? 60 / _speed : 0;
    final newLevel = ChadLevel.getChadLevelByPace(paceMinutesPerKm);

    if (newLevel.type != _currentChadLevel.type) {
      _currentChadLevel = newLevel;
      if (newLevel.vibrationCount > 0) {
        VibrationService.levelUpVibration();
      }
    }
  }

  WorkoutData getCurrentWorkoutData() {
    return WorkoutData(
      distance: _distance,
      speed: _speed,
      duration: _seconds,
      chadLevel: _currentChadLevel.name,
      startTime: DateTime.now().subtract(Duration(seconds: _seconds)),
    );
  }

  void resetWorkout() {
    _seconds = 0;
    _distance = 0.0;
    _speed = 0.0;
    _currentChadLevel = ChadLevel.levels[ChadLevelType.betaPace]!;
    notifyListeners();
  }

  @override
  void dispose() {
    _gpsService.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
