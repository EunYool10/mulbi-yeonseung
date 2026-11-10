using System;
using System.Collections.Generic;
using UnityEngine;

public static class MulbiBootstrap
{
    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
    static void CreateGame(){if(UnityEngine.Object.FindObjectOfType<MulbiGame>()==null)new GameObject("Mulbi · Game").AddComponent<MulbiGame>();}
}

// Runtime-built first playable scene. No imported assets are required.
public class MulbiGame : MonoBehaviour
{
    [Serializable] class SaveData { public int day=1, affection=0, trust=0, fish=0, chapter=1; public bool met=false; }
    SaveData data; GameObject player, yeonseung; Camera cam; CharacterController motor;
    float yaw, pitch=14, bob, fishingTime; bool cursorLocked, showDialog, fishing, journal;
    int dialogueStep; string toast="", fishResult=""; float toastUntil;
    readonly List<string> log = new List<string>();
    string[] lines = {"관리사님이죠? 길 찾느라 고생했겠다. 여긴 길이 하나뿐인데도 처음 오면 꼭 한 번은 돌아가게 되거든요.","저는 연이승이에요. 연꽃 연, 이길 승. 이름이 좀 이상하죠? 아버지는 어장에서 이기는 사람이 되길 바라셨나 봐요.","저쪽 깊은 물은 밤에 혼자 가지 마요. 예전부터 그랬어요.","해 지기 전엔 장부를 같이 정리해요. 그 다음엔 낚시도 알려줄게요. 여기서 제일 잘 잡히는 건 물고기가 아니지만."};
    string[][] choices = {new[]{"기다리고 있었어요?","여기 사는 사람은 다 길을 잃나요?"},new[]{"그럼 오늘은 내가 이기게 도와줘요.","어장에 대해 먼저 알려줘요."},new[]{"예전부터 무슨 일이 있었는데요?","알겠어요. 약속할게요."},new[]{"뭐가 잡히는데요?","내일 알려줘요. 오늘은 장부부터."}};
    void Start(){Application.targetFrameRate=60;Cursor.lockState=CursorLockMode.Locked;cursorLocked=true; data=Load();BuildWorld(); if(!data.met){ShowDialogue(0);data.met=true;Save();}}
    SaveData Load(){try{return JsonUtility.FromJson<SaveData>(PlayerPrefs.GetString("mulbi-save","{}"))??new SaveData();}catch{return new SaveData();}}
    void Save(){PlayerPrefs.SetString("mulbi-save",JsonUtility.ToJson(data));PlayerPrefs.Save();}
    Material Mat(Color c){var m=new Material(Shader.Find("Standard"));m.color=c;return m;}
    GameObject Cube(string n,Vector3 p,Vector3 s,Color c,Transform parent=null){var g=GameObject.CreatePrimitive(PrimitiveType.Cube);g.name=n;g.transform.position=p;g.transform.localScale=s;g.GetComponent<Renderer>().material=Mat(c);if(parent)g.transform.SetParent(parent);return g;}
    GameObject Sphere(string n,Vector3 p,Vector3 s,Color c,Transform parent=null){var g=GameObject.CreatePrimitive(PrimitiveType.Sphere);g.name=n;g.transform.position=p;g.transform.localScale=s;g.GetComponent<Renderer>().material=Mat(c);if(parent)g.transform.SetParent(parent);return g;}
    void BuildWorld(){
        RenderSettings.ambientLight=new Color(.65f,.71f,.66f);RenderSettings.fog=true;RenderSettings.fogColor=new Color(.46f,.59f,.59f);RenderSettings.fogDensity=.008f;Camera.main?.gameObject.SetActive(false);
        var ground=GameObject.CreatePrimitive(PrimitiveType.Plane);ground.name="Yeonseom · shore";ground.transform.localScale=new Vector3(16,1,16);ground.GetComponent<Renderer>().material=Mat(new Color(.36f,.40f,.32f));
        var pond=GameObject.CreatePrimitive(PrimitiveType.Cube);pond.name="Fishing pond";pond.transform.position=new Vector3(0,-.08f,-8);pond.transform.localScale=new Vector3(42,.12f,34);pond.GetComponent<Renderer>().material=Mat(new Color(.16f,.39f,.42f));
        Cube("Pier",new Vector3(0,.18f,-1),new Vector3(4,.36f,15),new Color(.39f,.29f,.21f));for(int z=-7;z<6;z+=2)for(int x=-1;x<=1;x+=2)Cube("Pier post",new Vector3(x,.02f,z),new Vector3(.22f,.7f,.22f),new Color(.25f,.19f,.15f));
        Cube("Tackle shed",new Vector3(-9,1.3f,-1),new Vector3(7,2.6f,5),new Color(.43f,.34f,.24f));var roof=Cube("Shed roof",new Vector3(-9,2.8f,-1),new Vector3(8,.35f,6),new Color(.23f,.20f,.17f));
        for(int i=0;i<45;i++){float x=UnityEngine.Random.Range(-29,29),z=UnityEngine.Random.Range(-28,22);if(Mathf.Abs(z+8)<12&&Mathf.Abs(x)<22)continue;var trunk=GameObject.CreatePrimitive(PrimitiveType.Cylinder);trunk.transform.position=new Vector3(x,1,z);trunk.transform.localScale=new Vector3(.25f,1.1f,.25f);trunk.GetComponent<Renderer>().material=Mat(new Color(.29f,.23f,.18f));var crown=GameObject.CreatePrimitive(PrimitiveType.Capsule);crown.transform.position=new Vector3(x,2.6f,z);crown.transform.localScale=new Vector3(1.6f,1.5f,1.6f);crown.GetComponent<Renderer>().material=Mat(new Color(.15f,.27f,.21f));}
        var light=new GameObject("Late afternoon sun").AddComponent<Light>();light.type=LightType.Directional;light.intensity=1.25f;light.color=new Color(1,.83f,.64f);light.transform.rotation=Quaternion.Euler(48,-34,0);
        yeonseung=new GameObject("Yeon Iseung");yeonseung.transform.position=new Vector3(5,0,2);var body=GameObject.CreatePrimitive(PrimitiveType.Capsule);body.transform.SetParent(yeonseung.transform);body.transform.localPosition=new Vector3(0,1,0);body.GetComponent<Renderer>().material=Mat(new Color(.87f,.84f,.75f));var head=Sphere("Face",yeonseung.transform.position+new Vector3(0,2,0),new Vector3(.72f,.82f,.72f),new Color(.88f,.69f,.58f),yeonseung.transform);head.transform.localPosition=new Vector3(0,2,0);var hair=Sphere("Hair",yeonseung.transform.position+new Vector3(0,2.2f,-.1f),new Vector3(.82f,.68f,.8f),new Color(.12f,.12f,.13f),yeonseung.transform);hair.transform.localPosition=new Vector3(0,2.2f,-.1f);var skirt=GameObject.CreatePrimitive(PrimitiveType.Cylinder);skirt.transform.SetParent(yeonseung.transform);skirt.transform.localPosition=new Vector3(0,.55f,0);skirt.transform.localScale=new Vector3(1,.42f,1);skirt.GetComponent<Renderer>().material=Mat(new Color(.35f,.48f,.42f));
        player=new GameObject("Player · caretaker");player.transform.position=new Vector3(0,0,10);motor=player.AddComponent<CharacterController>();motor.height=1.8f;motor.radius=.35f;motor.center=new Vector3(0,.9f,0);var avatar=GameObject.CreatePrimitive(PrimitiveType.Capsule);avatar.name="Caretaker";avatar.transform.SetParent(player.transform);avatar.transform.localPosition=new Vector3(0,.9f,0);avatar.GetComponent<Renderer>().material=Mat(new Color(.23f,.31f,.36f));Destroy(avatar.GetComponent<Collider>());
        var cgo=new GameObject("Player camera");cgo.tag="MainCamera";cam=cgo.AddComponent<Camera>();cam.fieldOfView=68;cam.nearClipPlane=.08f;cgo.AddComponent<AudioListener>();
    }
    void Update(){if(player==null)return;if(Input.GetKeyDown(KeyCode.Escape)){cursorLocked=false;Cursor.lockState=CursorLockMode.None;}if(Input.GetMouseButtonDown(0)&&!showDialog&&!journal){Cursor.lockState=CursorLockMode.Locked;cursorLocked=true;}
        if(cursorLocked&&!showDialog&&!journal&&!fishing){yaw+=Input.GetAxis("Mouse X")*2.2f;pitch-=Input.GetAxis("Mouse Y")*1.5f;pitch=Mathf.Clamp(pitch,-8,55);player.transform.rotation=Quaternion.Euler(0,yaw,0);Vector3 move=(player.transform.forward*Input.GetAxisRaw("Vertical")+player.transform.right*Input.GetAxisRaw("Horizontal"));if(move.sqrMagnitude>1)move.Normalize();motor.Move(move*4.2f*Time.deltaTime+Vector3.down*9.8f*Time.deltaTime);}
        Vector3 look=player.transform.position+Vector3.up*1.55f;Quaternion cameraRotation=Quaternion.Euler(pitch,yaw,0);cam.transform.position=look-cameraRotation*Vector3.forward*4.2f;cam.transform.rotation=cameraRotation;
        if(Input.GetKeyDown(KeyCode.E))Interact();if(fishing){fishingTime+=Time.deltaTime;if(Input.GetKeyDown(KeyCode.Space))CatchFish();if(fishingTime>9){fishing=false;fishResult="미끼만 사라졌다. 스페이스바로 찌가 빛날 때 당겨야 한다.";}}
        bob+=Time.deltaTime;yeonseung.transform.rotation=Quaternion.Slerp(yeonseung.transform.rotation,Quaternion.LookRotation(player.transform.position-yeonseung.transform.position),Time.deltaTime*2);
    }
    void Interact(){if(Vector3.Distance(player.transform.position,yeonseung.transform.position)<4){if(!showDialog)ShowDialogue(Mathf.Min(3,(data.day-1)%4));return;}if(Mathf.Abs(player.transform.position.x)<4&&player.transform.position.z<5&&player.transform.position.z>-15){fishing=true;fishingTime=0;fishResult="찌를 지켜보세요. 빛나는 순간 SPACE";return;}if(Mathf.Abs(player.transform.position.x+9)<5&&Mathf.Abs(player.transform.position.z+1)<5){journal=true;return;}Toast("물가나 연이승 가까이에서 E를 누르세요.");}
    void ShowDialogue(int i){dialogueStep=i;showDialog=true;}
    void Choose(int i){if(dialogueStep==0){if(i==0)data.affection++;else data.trust++;}else if(dialogueStep==1){if(i==0)data.affection++;else data.trust++;}else if(dialogueStep==2){if(i==0)data.chapter++;else data.affection++;}else{if(i==0)data.affection++;else data.trust++;data.day++;data.chapter=Mathf.Clamp((data.day+4)/5,1,12);log.Add("제"+data.day+"일: 이승은 깊은 물에 관한 이야기를 피했다.");}showDialog=false;Save();}
    void CatchFish(){fishing=false;float phase=(fishingTime%2.4f)/2.4f;bool success=phase>.45f&&phase<.69f;if(success){data.fish++;data.affection++;fishResult="은빛 붕어를 낚았다. 이승은 물고기보다 당신을 보고 있었다.";log.Add("은빛 붕어를 낚았다. 이승의 표정이 오래 기억에 남았다.");}else fishResult="물결만 남았다. 다음엔 찌가 빛날 때 당겨보자.";Save();Toast(fishResult);}
    void Toast(string s){toast=s;toastUntil=Time.time+3;}
    void OnGUI(){GUI.skin.label.fontSize=17;GUI.skin.label.normal.textColor=new Color(.94f,.91f,.82f);GUI.skin.button.fontSize=16;GUI.skin.button.normal.textColor=Color.white;GUI.Box(new Rect(0,0,Screen.width,56),"");GUI.Label(new Rect(22,12,300,36),"물비늘   ·   YEONSEOM");GUI.Label(new Rect(Screen.width-330,12,310,36),$"DAY {data.day:00}     ♡ {data.affection}     물고기 {data.fish}");GUI.Label(new Rect(20,75,480,62),$"오늘의 일\n{(data.day<8?"어장의 일과를 익히고, 이승과 가까워지기":"이승의 비밀과 오래된 어장 기록을 찾기")}");if(!showDialog&&!journal&&!fishing)GUI.Label(new Rect(Screen.width-310,82,290,60),"WASD 이동  ·  마우스 시점\n물가/E 대화  ·  E 상호작용");
        if(showDialog){GUI.Box(new Rect(Screen.width*.17f,Screen.height-205,Screen.width*.66f,175),"");GUI.contentColor=new Color(.9f,.77f,.52f);GUI.Label(new Rect(Screen.width*.19f,Screen.height-190,400,30),"연이승");GUI.contentColor=Color.white;GUI.Label(new Rect(Screen.width*.19f,Screen.height-158,Screen.width*.62f,64),lines[dialogueStep]);for(int i=0;i<2;i++)if(GUI.Button(new Rect(Screen.width*.19f+i*Screen.width*.31f,Screen.height-92,Screen.width*.29f,42),choices[dialogueStep][i]))Choose(i);}
        if(fishing){GUI.Box(new Rect(Screen.width*.33f,Screen.height*.47f,Screen.width*.34f,90),"낚시");float phase=(fishingTime%2.4f)/2.4f;GUI.Label(new Rect(Screen.width*.35f,Screen.height*.51f,Screen.width*.30f,32),phase>.45f&&phase<.69f?"✦ 찌가 빛난다! SPACE ✦":"찌를 지켜보세요...");}
        if(journal){GUI.Box(new Rect(Screen.width*.25f,Screen.height*.18f,Screen.width*.5f,Screen.height*.64f),"어장 관리 기록");GUI.Label(new Rect(Screen.width*.28f,Screen.height*.25f,Screen.width*.43f,100),$"제{data.day}일 · 연섬\n낚은 물고기 {data.fish}마리 · 이승과의 호감 {data.affection} · 신뢰 {data.trust}\n수면 위로 드러난 것들은 늘 이야기의 절반뿐이다.");if(GUI.Button(new Rect(Screen.width*.31f,Screen.height*.63f,Screen.width*.28f,40),"기록을 닫는다"))journal=false;if(GUI.Button(new Rect(Screen.width*.31f,Screen.height*.70f,Screen.width*.28f,40),"오늘의 일을 마치고 잠든다")){journal=false;data.day++;data.chapter=Mathf.Clamp((data.day+4)/5,1,12);Save();Toast("새로운 아침이 찾아왔다.");}}
        if(!string.IsNullOrEmpty(toast)&&Time.time<toastUntil)GUI.Box(new Rect(Screen.width*.25f,Screen.height*.28f,Screen.width*.5f,46),toast);
    }
}
