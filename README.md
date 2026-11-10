# 물비늘 — 연이승의 어장

**Unity 2022.3 LTS / C# 기반 PC용 3D 스토리 게임 프로젝트**입니다. 웹 게임으로 오해하게 만든 이전 데모는 `web-prototype/`에 보관했습니다. 게임 프로젝트는 `UnityProject/`입니다.

## Unity에서 실행하기

1. Unity Hub에서 **Unity 2022.3 LTS**와 Windows Build Support를 설치합니다.
2. `UnityProject/` 폴더를 Unity Hub에서 엽니다.
3. 상단 메뉴 **Mulbi → Create Playable Scene**을 선택합니다.
4. Play를 눌러 연섬 어장을 시작합니다.

장면과 캐릭터는 C#으로 런타임에 생성하므로 별도 에셋 다운로드는 필요하지 않습니다.

## Windows 실행 파일 만들기

Unity에서 **File → Build Profiles**를 열고 Windows를 선택한 뒤 Build를 실행합니다. 출력 폴더의 실행 파일과 데이터 폴더를 함께 배포하면 설치형/압축형 PC 빌드로 실행할 수 있습니다. 현재 작업 환경에는 Unity Editor가 없어 `.exe` 빌드는 생성하지 못했습니다.

## 조작

- WASD: 이동
- 마우스: 시점 회전 (마우스 클릭으로 포커스)
- E: 연이승과 대화 / 장소 상호작용
- 물가에서 E: 낚시 시작, 찌가 빛날 때 Space
- Escape: 마우스 잠금 해제

진행 상황은 로컬 PC의 PlayerPrefs에 저장됩니다.

## 현재 구현 범위

3D 어장과 인물, 이동, 첫 대화 선택, 낚시 미니게임, 하루 넘기기, 기록 저장을 담은 첫 플레이어블입니다. 5시간 이상 분량의 완성 시나리오, 여성 루트 전체, 남성 캐릭터 선택, 여러 엔딩은 아직 제작해야 합니다.
