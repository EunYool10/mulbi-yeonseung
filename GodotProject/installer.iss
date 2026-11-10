#define MyAppName "물비늘 - 연이승의 어장"
#define MyAppVersion "0.1.0"

[Setup]
AppId={{A6F6D597-BC28-47E6-82B1-C1005C6C9FA7}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=Mulbi Story Project
DefaultDirName={autopf}\Mulbi - Yeonseung
DefaultGroupName={#MyAppName}
OutputDir=..\..\..\outputs
OutputBaseFilename=Mulbi-Yeonseung-Setup
UninstallDisplayIcon={app}\Mulbi-Yeonseung.exe
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=admin
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Tasks]
Name: "desktopicon"; Description: "바탕 화면 바로 가기 만들기"; GroupDescription: "추가 작업:"; Flags: unchecked
Name: "runafterinstall"; Description: "설치 후 게임 실행"; GroupDescription: "추가 작업:"; Flags: unchecked

[Files]
Source: "..\..\..\outputs\Mulbi-Yeonseung.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "THIRD-PARTY-NOTICES.txt"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\Mulbi-Yeonseung.exe"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Mulbi-Yeonseung.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Mulbi-Yeonseung.exe"; Description: "{#MyAppName} 실행"; Flags: nowait postinstall skipifsilent; Tasks: runafterinstall
