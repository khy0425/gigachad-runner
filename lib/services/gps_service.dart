import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GPSService {
  Position? _currentPosition;
  Position? _previousPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  Function(Position)? _onPositionUpdate;

  bool get isTracking => _positionStreamSubscription != null;

  Future<bool> requestPermissions() async {
    await Permission.locationWhenInUse.request();
    return true;
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<bool> checkAndRequestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever;
  }

  Future<bool> startTracking({
    required Function(Position) onPositionUpdate,
  }) async {
    if (!await isLocationServiceEnabled()) {
      return false;
    }

    if (!await checkAndRequestPermissions()) {
      return false;
    }

    _onPositionUpdate = onPositionUpdate;

    _positionStreamSubscription =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10, // 10미터마다 업데이트
          ),
        ).listen((Position position) {
          _updatePosition(position);
        });

    return true;
  }

  void _updatePosition(Position position) {
    _previousPosition = _currentPosition;
    _currentPosition = position;

    if (_onPositionUpdate != null) {
      _onPositionUpdate!(position);
    }
  }

  double calculateDistance(Position previous, Position current) {
    return Geolocator.distanceBetween(
      previous.latitude,
      previous.longitude,
      current.latitude,
      current.longitude,
    );
  }

  void stopTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    _onPositionUpdate = null;
  }

  Position? get currentPosition => _currentPosition;
  Position? get previousPosition => _previousPosition;

  void dispose() {
    stopTracking();
  }
}
