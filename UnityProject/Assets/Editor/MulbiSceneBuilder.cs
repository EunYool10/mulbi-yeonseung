using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class MulbiSceneBuilder
{
    [MenuItem("Mulbi/Create Playable Scene")]
    public static void CreateScene()
    {
        if(!EditorUtility.DisplayDialog("물비늘", "플레이 가능한 시작 장면을 만들고 빌드 목록에 추가할까요?", "만들기", "취소")) return;
        System.IO.Directory.CreateDirectory("Assets/Scenes");
        var scene=EditorSceneManager.NewScene(NewSceneSetup.EmptyScene,NewSceneMode.Single);
        EditorSceneManager.SaveScene(scene,"Assets/Scenes/Yeonseom.unity");
        EditorBuildSettings.scenes=new[]{new EditorBuildSettingsScene("Assets/Scenes/Yeonseom.unity",true)};
        AssetDatabase.SaveAssets();
        EditorUtility.DisplayDialog("완료", "Assets/Scenes/Yeonseom.unity 를 만들었습니다. Play를 눌러 확인하거나 File > Build Profiles에서 Windows 빌드를 만드세요.", "확인");
    }
}
