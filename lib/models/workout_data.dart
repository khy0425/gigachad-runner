class WorkoutData {
  final double distance;
  final double speed;
  final int duration;
  final String chadLevel;
  final DateTime startTime;

  WorkoutData({
    required this.distance,
    required this.speed,
    required this.duration,
    required this.chadLevel,
    required this.startTime,
  });

  double get paceMinutesPerKm => speed > 0 ? 60 / speed : 0;

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'speed': speed,
      'duration': duration,
      'chadLevel': chadLevel,
      'startTime': startTime.toIso8601String(),
    };
  }

  factory WorkoutData.fromJson(Map<String, dynamic> json) {
    return WorkoutData(
      distance: json['distance']?.toDouble() ?? 0.0,
      speed: json['speed']?.toDouble() ?? 0.0,
      duration: json['duration'] ?? 0,
      chadLevel: json['chadLevel'] ?? '',
      startTime: DateTime.parse(json['startTime']),
    );
  }
}
