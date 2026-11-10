# 물비늘 — 연이승의 어장

Godot 4로 만드는 Windows용 3D 스토리 게임입니다. 연애 어장 관리는 여러 사람의 호감과 신뢰를 동시에 관리한다는 뜻입니다. 주인공 연이승은 17세 여성이고, 첫 상대 임찬우는 남학생들 앞에서 유난히 목소리를 높이고 허세를 부립니다. 다섯째 날에는 조용한 장부 담당 현김욱이 합류합니다. 플레이어의 선택은 두 사람의 비극적인 배드엔딩으로 이어집니다. 성적인 내용은 없습니다.

실제 사건과 절대 연관 있습니다.

## Windows 실행 파일

[Windows 설치 프로그램과 최신 빌드](https://github.com/EunYool10/mulbi-yeonseung/releases/latest)에서 `Mulbi-Yeonseung-Setup.exe`를 내려받아 설치하세요. 별도로 설치하고 싶지 않다면 `Mulbi-Yeonseung.exe`를 바로 실행할 수도 있습니다. 게임 데이터가 실행 파일에 포함되어 있어 Godot 설치는 필요하지 않습니다.

## 소스 프로젝트

- Godot 프로젝트: `GodotProject/`
- Unity 프로젝트는 이전 시도 자료로 `UnityProject/`에 남아 있습니다. Unity 라이선스가 없는 환경에서는 사용하지 않습니다.
- 렌더링은 Godot GL Compatibility, 물리 상호작용은 Godot 3D physics를 사용합니다.

Godot 4.7.2로 `GodotProject/project.godot`를 열면 편집할 수 있습니다. Windows 빌드에 필요한 내보내기 템플릿과 함께 CLI에서 `--export-release "Windows Desktop"`을 실행합니다.
Godot 엔진 및 포함된 서드파티 라이선스 고지는 `GodotProject/THIRD-PARTY-NOTICES.txt`에 있습니다.

## 조작

- WASD: 이동
- 마우스: 시점
- E: 인물과 대화 / 물가에서 낚시
- J: 연애 어장 장부
- 장부의 `오늘의 일을 마치고 잠든다`: 다음 날로 이동
- 물가에서 Space: 낚시 찌를 당기기
- Escape: 마우스 잠금 해제

## 현재 플레이 범위

현재 빌드는 3D 어장 산책, 두 인물과의 선택 대화, 호감·신뢰 장부, 간단한 물리 낚시, 30일째 배드엔딩을 담은 플레이어블 초안입니다. 5시간 이상 분량의 시나리오는 아직 완성되지 않았으며, 남성 주인공 선택 루트도 미구현입니다. 진행 상황은 로컬 `user://mulbi_save.json`에 저장됩니다.
