# 🏃‍♂️ GigaChad Runner

> **검정과 금색의 궁극적 달리기 앱** - Chad 밈을 활용한 GPS 기반 러닝 트래커

![Flutter](https://img.shields.io/badge/Flutter-3.32.0-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart)
![Android](https://img.shields.io/badge/Android-21+-3DDC84?style=for-the-badge&logo=android)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

## 📱 앱 소개

**GigaChad Runner**는 달리기 페이스에 따라 실시간으로 Chad 레벨을 판정하는 혁신적인 러닝 앱입니다. GPS 추적과 Chad 밈을 결합하여 재미있고 동기부여가 되는 운동 경험을 제공합니다.

### ✨ 핵심 기능

- 🎯 **실시간 GPS 추적** - 정확한 거리, 속도, 페이스 측정
- 🏆 **Chad 레벨 시스템** - 달리기 성능에 따른 동적 레벨 판정
- 📳 **진동 피드백** - Chad 레벨업 시 적절한 진동 알림
- 🎨 **검정/금색 테마** - 고급스러운 Chad 스타일 UI
- 📊 **상세 통계** - 개인 기록, 주간 통계, 진행률 추적
- 🖼️ **Chad 갤러리** - 다양한 Chad 밈 이미지 컬렉션

### 🎮 Chad 레벨 시스템

| 레벨 | 페이스 | 색상 | 설명 |
|------|--------|------|------|
| **Ultra Chad** | ≤ 5분/km | 브라이트 골드 | 궁극의 Chad |
| **Sigma Chad** | ≤ 6분/km | 골든로드 | 시그마 Chad |
| **Alpha Chad** | ≤ 7분/km | 다크 골든로드 | 알파 Chad |
| **Rising Chad** | ≤ 8분/km | 오렌지 골드 | 떠오르는 Chad |
| **Beta Pace** | > 8분/km | 어두운 회색 | 더 노력 필요 |

## 🏗️ 아키텍처

### MVC 패턴 기반 모듈화 구조

```
lib/
├── models/          # 데이터 모델
│   ├── workout_data.dart
│   └── chad_level.dart
├── providers/       # 상태 관리 (Provider 패턴)
│   ├── workout_provider.dart
│   └── chad_progress_provider.dart
├── screens/         # UI 화면
│   ├── home_screen.dart
│   ├── workout_screen.dart
│   ├── progress_screen.dart
│   ├── stats_screen.dart
│   └── settings_screen.dart
├── services/        # 비즈니스 로직
│   ├── gps_service.dart
│   └── vibration_service.dart
├── utils/          # 공통 유틸리티
│   └── app_colors.dart
└── main.dart       # 앱 진입점
```

### 📦 주요 의존성

```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.2          # 상태 관리
  geolocator: ^12.0.0       # GPS 추적
  permission_handler: ^11.3.1 # 권한 관리
  vibration: ^2.0.0         # 진동 피드백
  google_fonts: ^6.1.0      # 폰트
  sqflite: ^2.3.0          # 로컬 데이터베이스
  shared_preferences: ^2.2.2 # 설정 저장
```

## 🚀 빠른 시작

### 전제 조건

- Flutter 3.32.0 이상
- Dart 3.0 이상
- Android Studio / VS Code
- Android SDK (API 21 이상)

### 설치 및 실행

1. **저장소 클론**
   ```bash
   git clone https://github.com/your-username/gigachad-runner.git
   cd gigachad-runner/flutter_apps/gigachad_runner
   ```

2. **의존성 설치**
   ```bash
   flutter pub get
   ```

3. **권한 설정 확인**
   - `android/app/src/main/AndroidManifest.xml`에서 GPS 및 진동 권한 확인

4. **앱 실행**
   ```bash
   flutter run
   ```

5. **릴리즈 빌드**
   ```bash
   flutter build apk --release
   ```

## 🧪 테스트

### 단위 테스트 실행
```bash
flutter test
```

### 코드 분석
```bash
flutter analyze
```

### 커버리지 확인
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📱 화면 구성

### 🏠 홈 화면
- Chad 이미지 디스플레이
- 현재 Chad 레벨 표시
- 일일 진행률 프로그레스 바
- Chad 명언 표시

### 🏃‍♂️ 운동 화면
- 실시간 타이머
- GPS 기반 거리/속도 측정
- 동적 Chad 레벨 판정
- 시작/정지 버튼

### 📈 진행률 화면
- Chad 레벨 히스토리
- 일일/주간 달성률
- Chad 이미지 갤러리

### 📊 통계 화면
- 개인 최고 기록
- 주간 통계
- Chad 레벨 진화 차트

### ⚙️ 설정 화면
- 알림 설정
- 테마 변경
- 사용자 프로필

## 🔒 개인정보보호

- **완전한 오프라인 앱** - 로그인 불필요
- **로컬 데이터 저장** - 모든 데이터는 기기에만 저장
- **최소 권한** - GPS와 진동 권한만 사용
- **데이터 수집 없음** - 개인정보 수집하지 않음

## 🛠️ 개발 및 기여

### 개발 환경 설정

1. **코드 포맷팅**
   ```bash
   dart format .
   ```

2. **린트 검사**
   ```bash
   flutter analyze
   ```

3. **빌드 확인**
   ```bash
   flutter build apk --debug
   ```

### 기여 가이드라인

1. Fork 저장소
2. Feature 브랜치 생성 (`git checkout -b feature/amazing-feature`)
3. 변경사항 커밋 (`git commit -m 'feat: Add amazing feature'`)
4. 브랜치에 Push (`git push origin feature/amazing-feature`)
5. Pull Request 생성

### 커밋 컨벤션

```
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 업데이트
style: 코드 포맷팅
refactor: 코드 리팩토링
test: 테스트 추가/수정
chore: 빌드 프로세스 또는 보조 도구 변경
```

## 📋 로드맵

### Version 1.1.0
- [ ] 다크/라이트 테마 전환
- [ ] 운동 기록 데이터 익스포트
- [ ] Chad 성취 배지 시스템

### Version 1.2.0
- [ ] 소셜 공유 기능
- [ ] 운동 목표 설정
- [ ] 주간/월간 챌린지

### Version 2.0.0
- [ ] iOS 지원
- [ ] 클라우드 백업
- [ ] 커뮤니티 기능

## 🐛 알려진 이슈

- Android x86 에뮬레이터에서 GPS 시뮬레이션 필요
- 일부 저사양 기기에서 진동 지연 발생 가능

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 🙏 감사의 글

- [Flutter](https://flutter.dev/) - 크로스 플랫폼 UI 프레임워크
- [Provider](https://pub.dev/packages/provider) - 상태 관리
- [Geolocator](https://pub.dev/packages/geolocator) - GPS 추적
- Chad 밈 커뮤니티 - 영감과 동기부여

## 📞 연락처

프로젝트와 관련된 질문이나 제안사항이 있으시면 이슈를 생성해주세요.

---

**Made with 💪 by Chad Developers**

*"약한 자는 복수를 꿈꾸고, 강한 자는 용서를 배운다. 하지만 기가차드는 그냥 달린다."*