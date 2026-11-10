extends Node3D

const SAVE_PATH := "user://mulbi_save.json"
const CHANWOO_LINES := [
	"야, 나 어제 그물 혼자 들었다? 별거 아니던데. 임찬우는 원래 이런 거 잘해. 찬우가 남학생들 앞에서 일부러 목소리를 키웠다.",
	"사람들이 가고 나자 찬우는 젖은 손을 바지에 문질렀다. ‘아까 건 그냥 분위기 맞춘 거야. 내가 원래 그런 애는 아닌데.’",
	"‘연이승, 네가 옆에 있으면 다들 내가 진짜 대단한 줄 알아.’ 찬우의 웃음은 자랑과 부탁 사이에서 흔들렸다.",
	"축제 날, 찬우는 또 사람들 앞에서 허세를 부렸다. 이번엔 망신당하지 않게 거짓말을 보태 달라고 눈짓했다."
]
const CHANWOO_CHOICES := [
	["사람들 앞에서 찬우의 허세를 부추긴다.", "‘그물 무거웠지?’ 둘만 있을 때 물어본다."],
	["‘다들 네가 멋있다고 하더라.’ 미끼를 던진다.", "‘애쓰는 거 알아.’ 조용히 편을 들어준다."],
	["찬우의 자랑에 맞장구치고 더 큰 약속을 받아낸다.", "그가 두려워하는 걸 다른 남학생들 앞에서 감춰준다."],
	["찬우 대신 거짓말해 그를 붙잡는다.", "솔직히 말하라고 하고 관계를 건다."]
]
const KIMUK_LINES := [
	"제방 수리 도와줄게. 대신 네가 장부 정리 좀 보여줘. 난 숫자 정리하는 게 편하거든.",
	"찬우가 떠난 뒤에도 김욱은 의자를 접었다. ‘너는 사람들 마음도 장부처럼 칸칸이 나눠 적어?’",
	"‘나도 네 어장에 들어가 있는 거야?’ 현김욱은 웃으려 했지만 대답을 기다리는 눈을 숨기지 못했다.",
	"축제 전날, 김욱은 이승의 기록장을 돌려줬다. 찬우 이름 아래 자기 이름이 적힌 걸 이미 봤다고 했다."
]
const KIMUK_CHOICES := [
	["‘네가 있어서 일이 빨라.’ 곁에 붙잡아 둔다.", "‘고마워. 너한테는 솔직하게 말할게.’"],
	["그를 안심시키고 다른 약속도 받아낸다.", "장부에 이름을 적은 이유를 말한다."],
	["‘당연히 특별하지.’ 그가 믿고 싶은 말을 고른다.", "‘모르겠어.’ 처음으로 꾸미지 않고 답한다."],
	["찬우 앞에서 김욱의 마음을 모른 척한다.", "김욱의 이름을 장부에서 지우고 선택을 존중한다."]
]
const CHAPTERS := [
	"방학 동안 아버지의 어장을 맡은 17살 연이승. 첫날, 임찬우는 다른 남학생들 앞에서 일부러 목소리를 높였다.",
	"찬우는 사람들 앞에서만 더 크게 웃었다. 이승은 그 웃음이 누구를 향하는지 보기 시작했다.",
	"찬우가 그물에 발이 걸려 넘어질 뻔한 날, 이승은 놀리는 대신 손을 내밀었다. 그는 그 일을 아무에게도 말하지 않았다.",
	"찬우가 허세를 부릴 때마다 주변 아이들은 웃었다. 웃음이 끝나면 찬우는 이승의 표정을 먼저 확인했다.",
	"다섯째 날, 장부 담당 현김욱이 어장에 왔다. 그는 찬우의 과장도 이승의 기록도 조용히 지켜봤다.",
	"마을 축제 준비가 시작됐다. 찬우는 무대에서 어장 일을 혼자 해냈다고 자랑했고, 이승에게 사실을 맞춰 달라고 했다.",
	"둘만 남은 방파제에서 찬우는 처음으로 목소리를 낮췄다. 그때 이승은 자기 마음보다 그의 약점을 먼저 기억했다.",
	"축제 연습 영상이 퍼졌다. 찬우의 과장은 농담거리가 됐고, 이승은 자신이 던진 미끼의 무게를 느꼈다.",
	"김욱은 여러 이름이 적힌 장부를 돌려주며 물었다. ‘정말 한 사람씩 좋아하는 거야?’",
	"찬우는 더 큰소리로 떠들며 아무렇지 않은 척했다. 아무도 없는 창고에서만 손이 떨렸다.",
	"‘너는 내가 어떤 사람인지 궁금한 거야, 아니면 내가 너를 좋아하는 게 좋은 거야?’ 찬우가 물었다.",
	"마지막 축제 날. 어장엔 찬우의 낡은 낚싯대와 김욱의 빈 장부만 남았다."
]

var state := {"day": 1, "affection": 0, "trust": 0, "fish": 0, "chapter": 1, "chanwoo_bond": 0, "kimuk_bond": 0, "kimuk_trust": 0, "met": false}
var player: CharacterBody3D
var camera: Camera3D
var chanwoo: Node3D
var kimuk: Node3D
var bobber: RigidBody3D
var hud_day: Label
var hud_bonds: Label
var objective: Label
var dialogue_panel: PanelContainer
var speaker_label: Label
var story_label: Label
var choice_buttons: Array[Button] = []
var journal_panel: PanelContainer
var journal_label: Label
var dialogue_step := 0
var current_boy := 0
var dialogue_open := false
var journal_open := false
var ended := false
var fishing := false
var fishing_time := 0.0
var camera_yaw := 0.0
var camera_pitch := -0.12
var toast_label: Label
var toast_timer := 0.0

func _ready() -> void:
	_load_save()
	build_world()
	build_ui()
	refresh_hud()
	if not state.met:
		state.met = true
		show_dialogue(0, 0)
		_save()

func _physics_process(delta: float) -> void:
	if player == null:
		return
	if not dialogue_open and not journal_open and not fishing and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var axis := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var forward := -player.global_basis.z
		var right := player.global_basis.x
		var move := (right * axis.x + forward * -axis.y).normalized()
		player.velocity.x = move.x * 4.2
		player.velocity.z = move.z * 4.2
		if not player.is_on_floor():
			player.velocity.y -= 20.0 * delta
		elif Input.is_action_just_pressed("jump"):
			player.velocity.y = 5.2
		player.move_and_slide()
	if bobber != null and is_instance_valid(bobber):
		if absf(bobber.global_position.x) < 22.0 and bobber.global_position.z < 9.0 and bobber.global_position.z > -26.0:
			var depth := -0.03 - bobber.global_position.y
			bobber.apply_central_force(Vector3.UP * clampf(depth * 120.0, -3.0, 160.0) + Vector3.UP * sin(Time.get_ticks_msec() * 0.002) * 1.7)

func _process(delta: float) -> void:
	if toast_timer > 0.0:
		toast_timer -= delta
		if toast_timer <= 0.0:
			toast_label.hide()
	if fishing:
		fishing_time += delta
		if fishing_time > 9.0:
			fishing = false
			show_toast("미끼만 사라졌다. 물 위에 뜬 찌를 다시 살펴보자.")
	if not ended and int(state.day) >= 30:
		ended = true
		show_bad_ending()
	if kimuk != null:
		kimuk.visible = int(state.day) >= 5
		if kimuk.visible:
			kimuk.look_at(Vector3(player.global_position.x, kimuk.global_position.y, player.global_position.z), Vector3.UP)
	if chanwoo != null:
		chanwoo.look_at(Vector3(player.global_position.x, chanwoo.global_position.y, player.global_position.z), Vector3.UP)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and not dialogue_open and not journal_open:
		camera_yaw -= event.relative.x * 0.003
		camera_pitch = clampf(camera_pitch - event.relative.y * 0.002, -0.55, 0.45)
		player.rotation.y = camera_yaw
		camera.rotation.x = camera_pitch
	if event.is_action_pressed("interact"):
		interact()
	if event.is_action_pressed("journal"):
		open_journal()
	if event.is_action_pressed("cancel"):
		if dialogue_open:
			close_dialogue()
		elif journal_open:
			close_journal()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("fish_pull") and fishing:
		catch_fish()
	if event is InputEventMouseButton and event.pressed and not dialogue_open and not journal_open:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func build_world() -> void:
	var world_env := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_SKY
	env.sky = Sky.new()
	var sky_mat := ProceduralSkyMaterial.new()
	sky_mat.sky_top_color = Color("526f85")
	sky_mat.sky_horizon_color = Color("c5ad8d")
	sky_mat.ground_bottom_color = Color("303b37")
	sky_mat.ground_horizon_color = Color("889082")
	env.sky.sky_material = sky_mat
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color("b7c2b1")
	env.ambient_light_energy = 0.7
	world_env.environment = env
	add_child(world_env)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-38.0, -28.0, 0.0)
	sun.light_color = Color("ffe0ad")
	sun.light_energy = 1.4
	add_child(sun)
	make_static_box("섬의 흙길", Vector3(0,-0.55,0), Vector3(100,1,100), Color("66715e"))
	var water_mesh := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(44, 36)
	water_mesh.mesh = plane
	water_mesh.position = Vector3(0,-0.07,-8)
	var water_mat := StandardMaterial3D.new()
	water_mat.albedo_color = Color(0.12,0.35,0.39,0.86)
	water_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_mat.roughness = 0.2
	water_mat.metallic = 0.25
	water_mesh.material_override = water_mat
	add_child(water_mesh)
	make_static_box("부두", Vector3(0,0.15,-1), Vector3(4,0.35,15), Color("76593e"))
	for z in range(-7, 7, 2):
		for x in [-1.8, 1.8]:
			make_static_box("부두 기둥", Vector3(x,-0.22,z), Vector3(0.2,0.8,0.2), Color("4c3b2c"))
	make_static_box("관리소", Vector3(-9,1.25,-1), Vector3(7,2.5,5), Color("806849"))
	make_static_box("관리소 지붕", Vector3(-9,2.7,-1), Vector3(8,0.35,6), Color("473c33"))
	for i in range(42):
		var x := randf_range(-28,28)
		var z := randf_range(-27,20)
		if absf(z + 8) < 12 and absf(x) < 22:
			continue
		make_tree(Vector3(x,0,z), randf_range(0.8,1.4))
	build_player()
	chanwoo = build_boy("임찬우 · 17", Vector3(5,0,2), Color("38556a"), Color("1c1c21"))
	kimuk = build_boy("현김욱 · 17", Vector3(-3,0,3), Color("61714f"), Color("382f28"))
	kimuk.visible = int(state.day) >= 5
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func build_player() -> void:
	player = CharacterBody3D.new()
	player.name = "연이승 · 17세"
	player.position = Vector3(0,0.08,10)
	var collider := CollisionShape3D.new()
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.38
	capsule.height = 1.8
	collider.shape = capsule
	collider.position.y = 0.9
	player.add_child(collider)
	var body_mesh := CapsuleMesh.new()
	body_mesh.radius = 0.36
	body_mesh.height = 1.45
	var body := MeshInstance3D.new()
	body.mesh = body_mesh
	body.position.y = 0.9
	body.material_override = make_material(Color("e3dac8"))
	player.add_child(body)
	var skirt := MeshInstance3D.new()
	var skirt_mesh := CylinderMesh.new()
	skirt_mesh.top_radius = 0.35
	skirt_mesh.bottom_radius = 0.53
	skirt_mesh.height = 0.55
	skirt.mesh = skirt_mesh
	skirt.position.y = 0.47
	skirt.material_override = make_material(Color("697d74"))
	player.add_child(skirt)
	add_sphere(player, "이승의 얼굴", Vector3(0,1.82,0), Vector3(0.35,0.4,0.34), Color("e3bcaa"))
	add_sphere(player, "이승의 머리", Vector3(0,2.04,-0.06), Vector3(0.39,0.32,0.37), Color("252329"))
	add_sphere(player, "머리 리본", Vector3(-0.34,2.16,-0.04), Vector3(0.11,0.08,0.1), Color("a64e51"))
	camera = Camera3D.new()
	camera.position = Vector3(0,1.62,4.2)
	camera.current = true
	player.add_child(camera)
	add_child(player)

func build_boy(title: String, at: Vector3, jacket: Color, hair: Color) -> Node3D:
	var boy := Node3D.new()
	boy.name = title
	boy.position = at
	var body := MeshInstance3D.new()
	var mesh := CapsuleMesh.new()
	mesh.radius = 0.42
	mesh.height = 1.75
	body.mesh = mesh
	body.position.y = 0.9
	body.material_override = make_material(jacket)
	boy.add_child(body)
	add_sphere(boy, "얼굴", Vector3(0,1.95,0), Vector3(0.36,0.42,0.35), Color("d4a98f"))
	add_sphere(boy, "머리", Vector3(0,2.18,-0.03), Vector3(0.39,0.3,0.37), hair)
	add_child(boy)
	return boy

func make_static_box(title: String, at: Vector3, size: Vector3, color: Color) -> void:
	var body := StaticBody3D.new()
	body.name = title
	body.position = at
	var shape_node := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	shape_node.shape = shape
	body.add_child(shape_node)
	var mesh_node := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh_node.mesh = mesh
	mesh_node.material_override = make_material(color)
	body.add_child(mesh_node)
	add_child(body)

func make_tree(at: Vector3, scale_factor: float) -> void:
	var root := Node3D.new()
	root.position = at
	var trunk := MeshInstance3D.new()
	var trunk_mesh := CylinderMesh.new()
	trunk_mesh.top_radius = 0.12 * scale_factor
	trunk_mesh.bottom_radius = 0.22 * scale_factor
	trunk_mesh.height = 2.5 * scale_factor
	trunk.mesh = trunk_mesh
	trunk.position.y = 1.25 * scale_factor
	trunk.material_override = make_material(Color("554535"))
	root.add_child(trunk)
	for tier in range(3):
		var crown := MeshInstance3D.new()
		var cone := CylinderMesh.new()
		cone.top_radius = 0.0
		cone.bottom_radius = (1.05 - tier * 0.18) * scale_factor
		cone.height = 1.65 * scale_factor
		crown.mesh = cone
		crown.position.y = (2.3 + tier * 0.65) * scale_factor
		crown.material_override = make_material(Color("315346") if tier % 2 == 0 else Color("3b5d4a"))
		root.add_child(crown)
	add_child(root)

func add_sphere(parent: Node3D, title: String, at: Vector3, scale_value: Vector3, color: Color) -> void:
	var node := MeshInstance3D.new()
	node.name = title
	var mesh := SphereMesh.new()
	mesh.radius = 0.5
	mesh.height = 1.0
	node.mesh = mesh
	node.position = at
	node.scale = scale_value * 2.0
	node.material_override = make_material(color)
	parent.add_child(node)

func make_material(color: Color) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.82
	return material

func build_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var root := Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(root)
	var top := PanelContainer.new()
	top.set_anchors_preset(Control.PRESET_TOP_WIDE)
	top.offset_bottom = 60
	top.add_theme_stylebox_override("panel", style_panel(Color(0.05,0.09,0.12,0.88)))
	root.add_child(top)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 18)
	top.add_child(row)
	var brand := Label.new()
	brand.text = "물비늘 · 연이승, 17"
	brand.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(brand)
	hud_day = Label.new()
	hud_day.text = "DAY 01"
	row.add_child(hud_day)
	hud_bonds = Label.new()
	row.add_child(hud_bonds)
	var journal_button := Button.new()
	journal_button.text = "연애 어장 장부 [J]"
	journal_button.pressed.connect(open_journal)
	row.add_child(journal_button)
	var objective_box := PanelContainer.new()
	objective_box.position = Vector2(20,80)
	objective_box.custom_minimum_size = Vector2(420,70)
	root.add_child(objective_box)
	objective = Label.new()
	objective.text = "오늘: 임찬우의 허세를 읽는다"
	objective_box.add_child(objective)
	var hint := Label.new()
	hint.text = "WASD 이동 · 마우스 시점 · E 대화/낚시"
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	hint.position = Vector2(-400,90)
	hint.size = Vector2(380,55)
	hint.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	root.add_child(hint)
	dialogue_panel = PanelContainer.new()
	dialogue_panel.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	dialogue_panel.anchor_left = 0.15
	dialogue_panel.anchor_right = 0.85
	dialogue_panel.offset_top = -240
	dialogue_panel.offset_bottom = -18
	dialogue_panel.add_theme_stylebox_override("panel", style_panel(Color(0.05,0.08,0.11,0.95)))
	root.add_child(dialogue_panel)
	var dialog_vbox := VBoxContainer.new()
	dialog_vbox.add_theme_constant_override("separation", 8)
	dialogue_panel.add_child(dialog_vbox)
	speaker_label = Label.new()
	speaker_label.add_theme_color_override("font_color", Color("e3c98f"))
	dialog_vbox.add_child(speaker_label)
	story_label = Label.new()
	story_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	story_label.custom_minimum_size.y = 92
	dialog_vbox.add_child(story_label)
	var button_row := HBoxContainer.new()
	button_row.add_theme_constant_override("separation", 10)
	dialog_vbox.add_child(button_row)
	for i in range(2):
		var button := Button.new()
		button.custom_minimum_size.y = 44
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.pressed.connect(choose.bind(i))
		button_row.add_child(button)
		choice_buttons.append(button)
	dialogue_panel.hide()
	journal_panel = PanelContainer.new()
	journal_panel.set_anchors_preset(Control.PRESET_CENTER)
	journal_panel.anchor_left = 0.22
	journal_panel.anchor_right = 0.78
	journal_panel.anchor_top = 0.2
	journal_panel.anchor_bottom = 0.8
	journal_panel.add_theme_stylebox_override("panel", style_panel(Color(0.07,0.1,0.12,0.98)))
	root.add_child(journal_panel)
	var journal_vbox := VBoxContainer.new()
	journal_panel.add_child(journal_vbox)
	var title := Label.new()
	title.text = "연애 어장 관리표"
	title.add_theme_font_size_override("font_size", 24)
	journal_vbox.add_child(title)
	journal_label = Label.new()
	journal_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	journal_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	journal_vbox.add_child(journal_label)
	var journal_row := HBoxContainer.new()
	journal_vbox.add_child(journal_row)
	var close_button := Button.new()
	close_button.text = "닫기"
	close_button.pressed.connect(close_journal)
	journal_row.add_child(close_button)
	var sleep_button := Button.new()
	sleep_button.text = "오늘의 일을 마치고 잠든다"
	sleep_button.pressed.connect(sleep_to_next_day)
	journal_row.add_child(sleep_button)
	journal_panel.hide()
	toast_label = Label.new()
	toast_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	toast_label.set_anchors_preset(Control.PRESET_CENTER_TOP)
	toast_label.offset_top = 135
	toast_label.offset_left = -300
	toast_label.offset_right = 300
	root.add_child(toast_label)
	toast_label.hide()
	setup_input()

func setup_input() -> void:
	var mappings := {"move_forward": KEY_W, "move_back": KEY_S, "move_left": KEY_A, "move_right": KEY_D, "interact": KEY_E, "journal": KEY_J, "jump": KEY_SPACE, "fish_pull": KEY_SPACE, "cancel": KEY_ESCAPE}
	for action in mappings:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		var key_event := InputEventKey.new()
		key_event.physical_keycode = mappings[action]
		InputMap.action_add_event(action, key_event)

func style_panel(color: Color) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.border_color = Color("cfb979")
	box.set_border_width_all(1)
	box.set_corner_radius_all(8)
	box.content_margin_left = 16
	box.content_margin_right = 16
	box.content_margin_top = 12
	box.content_margin_bottom = 12
	return box

func refresh_hud() -> void:
	hud_day.text = "DAY %02d" % int(state.day)
	hud_bonds.text = "♡ 임찬우 %d · 현김욱 %d" % [int(state.chanwoo_bond), int(state.kimuk_bond)]
	if int(state.day) < 5:
		objective.text = "오늘: 첫 상대 임찬우의 허세를 읽는다"
	elif int(state.day) < 30:
		objective.text = "오늘: 임찬우와 현김욱의 마음을 동시에 관리한다"
	else:
		objective.text = "마지막 축제에서 관계의 대가를 마주한다"
	_save()

func show_dialogue(step: int, boy: int) -> void:
	dialogue_step = clampi(step, 0, 3)
	current_boy = boy
	dialogue_open = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	dialogue_panel.show()
	speaker_label.text = "임찬우 · 17세" if boy == 0 else "현김욱 · 17세"
	var choice_data: Array = CHANWOO_CHOICES[dialogue_step] if boy == 0 else KIMUK_CHOICES[dialogue_step]
	for i in range(2):
		choice_buttons[i].text = choice_data[i]
	if boy == 1:
		story_label.text = "제%d일. 찬우가 사람들 앞에서 목소리를 높이는 동안 김욱은 장부의 숫자를 조용히 고쳐 놓았다.\n\n%s" % [int(state.day), KIMUK_LINES[dialogue_step]] if dialogue_step == 0 else KIMUK_LINES[dialogue_step]
	elif dialogue_step == 0:
		story_label.text = CHAPTERS[clampi(int(state.chapter) - 1, 0, CHAPTERS.size() - 1)] + "\n\n" + CHANWOO_LINES[0]
	else:
		story_label.text = CHANWOO_LINES[dialogue_step]

func choose(index: int) -> void:
	if ended:
		if index == 0:
			restart_game()
		else:
			close_bad_ending()
		return
	var lure := index == 0
	if current_boy == 0:
		if lure:
			state.affection += 1
			state.chanwoo_bond += 1
		else:
			state.trust += 1
	else:
		if lure:
			state.affection += 1
			state.kimuk_bond += 1
		else:
			state.trust += 1
			state.kimuk_trust += 1
	if dialogue_step == 3:
		state.day += 1
		state.chapter = clampi(int(ceil(float(state.day) / 5.0)), 1, 12)
		story_log("제%d일: 두 사람의 이름이 장부의 서로 다른 칸에 적혔다." % int(state.day))
	close_dialogue()
	refresh_hud()

func close_dialogue() -> void:
	dialogue_open = false
	dialogue_panel.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func interact() -> void:
	if dialogue_open or journal_open or ended:
		return
	if int(state.day) >= 5 and global_distance(player, kimuk) < 3.8:
		show_dialogue((int(state.day) - 5) % 4, 1)
		return
	if global_distance(player, chanwoo) < 3.8:
		show_dialogue((int(state.day) - 1) % 4, 0)
		return
	if absf(player.global_position.x) < 4.0 and player.global_position.z < 5.0 and player.global_position.z > -16.0:
		cast_fishing_rod()
		return
	show_toast("임찬우나 현김욱에게 다가가 E를 누르거나, 물가에서 낚싯대를 던져보자.")

func global_distance(a: Node3D, b: Node3D) -> float:
	return a.global_position.distance_to(b.global_position)

func cast_fishing_rod() -> void:
	if fishing:
		return
	fishing = true
	fishing_time = 0.0
	show_toast("찌를 던졌다. 흔들리고 빛날 때 SPACE로 당긴다.")
	if is_instance_valid(bobber):
		bobber.queue_free()
	bobber = RigidBody3D.new()
	bobber.name = "물리 낚싯찌"
	bobber.mass = 0.15
	bobber.position = player.global_position + (-player.global_basis.z * 2.6) + Vector3.UP * 1.5
	var shape := CollisionShape3D.new()
	var sphere := SphereShape3D.new()
	sphere.radius = 0.1
	shape.shape = sphere
	bobber.add_child(shape)
	var visual := MeshInstance3D.new()
	var sphere_mesh := SphereMesh.new()
	sphere_mesh.radius = 0.1
	sphere_mesh.height = 0.2
	visual.mesh = sphere_mesh
	visual.material_override = make_material(Color("e8a35f"))
	bobber.add_child(visual)
	add_child(bobber)
	bobber.apply_central_impulse((-player.global_basis.z * 4.0) + Vector3.UP * 1.2)

func catch_fish() -> void:
	fishing = false
	var phase := fmod(fishing_time, 2.4) / 2.4
	if phase > 0.45 and phase < 0.69:
		state.fish += 1
		state.affection += 1
		show_toast("은빛 붕어를 낚았다. 마음 장부도 한 줄 채워졌다.")
		story_log("은빛 붕어 한 마리. 찬우는 물고기보다 이승을 보고 있었다.")
	else:
		show_toast("물결만 남았다. 찌가 빛날 때 당겨야 한다.")
	refresh_hud()

func open_journal() -> void:
	if dialogue_open or ended:
		return
	journal_open = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	journal_label.text = "제%d일 · 연섬 어장\n주인공 연이승, 17세\n\n임찬우 — 사람들 앞에서 허세 부리는 첫 상대\n호감 %d · 신뢰 %d\n\n현김욱 — 다섯째 날 합류한 장부 담당\n호감 %d · 신뢰 %d\n\n오늘 낚은 물고기: %d마리\n여러 사람의 마음을 한 장부에서 관리한다." % [int(state.day), int(state.chanwoo_bond), int(state.trust), int(state.kimuk_bond), int(state.kimuk_trust), int(state.fish)]
	journal_panel.show()

func close_journal() -> void:
	journal_open = false
	journal_panel.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func sleep_to_next_day() -> void:
	state.day += 1
	state.chapter = clampi(int(ceil(float(state.day) / 5.0)), 1, 12)
	close_journal()
	refresh_hud()
	show_toast("새 아침. 장부에 오늘의 만남이 추가됐다.")
	if state.day >= 30:
		show_bad_ending()

func show_bad_ending() -> void:
	ended = true
	dialogue_open = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	dialogue_panel.show()
	speaker_label.text = "BAD ENDING · 빈 연애 어장"
	story_label.text = "찬우는 축제가 끝난 날 섬을 떠났다. 네가 보탠 거짓말이 모두에게 드러났기 때문이다. 현김욱은 장부를 돌려주고 가족을 따라 전학 갔다. 두 사람은 끝내 서로의 진심을 확인하지 못했다.\n\n남은 어장에는 빈 기록장만 놓여 있었다. 여러 사람의 마음을 관리했지만, 누구도 곁에 남지 않았다."
	choice_buttons[0].text = "처음부터 다시"
	choice_buttons[1].text = "기록 닫기"

func restart_game() -> void:
	DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_PATH))
	get_tree().reload_current_scene()

func close_bad_ending() -> void:
	dialogue_panel.hide()
	show_toast("이 이야기는 여기서 끝난다.")

func show_toast(message: String) -> void:
	toast_label.text = message
	toast_label.show()
	toast_timer = 2.5

func story_log(message: String) -> void:
	var history: Array = state.get("log", [])
	history.append(message)
	state["log"] = history

func _save() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(state))

func _load_save() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return
	var parsed = JSON.parse_string(file.get_as_text())
	if parsed is Dictionary and int(parsed.get("day", 0)) > 0:
		for key in parsed:
			state[key] = parsed[key]

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_PREDELETE:
		_save()
