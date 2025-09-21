import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
          return Stack(
            children: [
              // 지도 배경
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  // 지도 컨트롤러 설정
                },
                initialCameraPosition: CameraPosition(
                  target: provider.currentPosition != null
                      ? LatLng(
                          provider.currentPosition!.latitude,
                          provider.currentPosition!.longitude,
                        )
                      : const LatLng(37.5665, 126.9780), // 서울 기본 위치
                  zoom: 16.0,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                polylines: Set<Polyline>.from([
                  if (provider.routePoints.isNotEmpty)
                    Polyline(
                      polylineId: const PolylineId('route'),
                      points: provider.routePoints
                          .map((pos) => LatLng(pos.latitude, pos.longitude))
                          .toList(),
                      color: AppColors.chadGold,
                      width: 5,
                      patterns: [PatternItem.solid(10)],
                    ),
                ]),
                markers: Set<Marker>.from([
                  if (provider.currentPosition != null)
                    Marker(
                      markerId: const MarkerId('current'),
                      position: LatLng(
                        provider.currentPosition!.latitude,
                        provider.currentPosition!.longitude,
                      ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueYellow,
                      ),
                    ),
                ]),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
              ),

              // 상단 정보 패널
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.pureBlack,
                        AppColors.pureBlack.withValues(alpha: 0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // 시간과 Chad 레벨
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.formattedTime,
                              style: GoogleFonts.bebasNeue(
                                fontSize: 42,
                                color: AppColors.chadGold,
                                shadows: [
                                  Shadow(
                                    color: AppColors.pureBlack,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: provider.currentChadLevel.color.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: provider.currentChadLevel.color,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                provider.currentChadLevel.name,
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: AppColors.pureBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // 통계 카드들
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildCompactStatCard(
                              '거리',
                              '${provider.distance.toStringAsFixed(2)}km',
                            ),
                            _buildCompactStatCard(
                              '속도',
                              '${provider.speed.toStringAsFixed(1)}km/h',
                            ),
                            _buildCompactStatCard(
                              '페이스',
                              provider.formattedPace,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 하단 컨트롤 패널
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.pureBlack,
                        AppColors.pureBlack.withValues(alpha: 0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                              horizontal: 50,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                          ),
                          child: Text(
                            provider.isRunning ? '정지' : '시작',
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // 리셋 버튼
                        if (!provider.isRunning && provider.seconds > 0)
                          TextButton(
                            onPressed: provider.resetWorkout,
                            child: Text(
                              '리셋',
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCompactStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.pureBlack.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.chadGold.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.robotoCondensed(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.bebasNeue(
              fontSize: 16,
              color: AppColors.chadGold,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: AppColors.pureBlack,
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ],
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
