import 'package:flutter/material.dart';

class AppColors {
  // Chad 테마 색상 - 검정과 금색 베이스
  static const Color chadGold = Color(0xFFFFD700); // 메인 골드
  static const Color chadGoldDark = Color(0xFFB8860B); // 어두운 골드
  static const Color pureBlack = Color(0xFF000000); // 순수 검정
  static const Color charcoalBlack = Color(0xFF0A0A0A); // 차콜 검정
  static const Color cardBackground = Color(0xFF1C1C1C); // 카드 배경 (더 어둡게)
  static const Color borderGold = Color(0xFFDAA520); // 골드 테두리

  // Chad 레벨별 색상 (골드 베이스 변형)
  static const Color ultraChad = Color(0xFFFFD700); // 브라이트 골드
  static const Color sigmaChad = Color(0xFFDAA520); // 골든로드
  static const Color alphaChad = Color(0xFFB8860B); // 다크 골든로드
  static const Color risingChad = Color(0xFFFFA500); // 오렌지 골드
  static const Color betaPace = Color(0xFF696969); // 어두운 회색

  // 상태 색상
  static const Color errorRed = Color(0xFFDC143C); // 크림슨 레드
  static const Color successGold = Color(0xFFFFD700);
  static const Color warningAmber = Color(0xFFFFC107);

  // 텍스트 색상
  static const Color textPrimary = Color(0xFFFFD700); // 골드 텍스트
  static const Color textSecondary = Color(0xFFE6E6E6); // 밝은 회색
  static const Color textTertiary = Color(0xFFB3B3B3); // 중간 회색
  static const Color textOnGold = Color(0xFF000000); // 골드 배경 위 검정 텍스트

  // 네비게이션
  static const Color selectedItem = chadGold;
  static const Color unselectedItem = textTertiary;

  // 배경 색상
  static const Color scaffoldBackground = pureBlack;
  static const Color appBarBackground = charcoalBlack;
}
