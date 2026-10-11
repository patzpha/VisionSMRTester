extends Node

@onready var vr_viewer = $VRViewer
@onready var diagnostics = $Diagnostics
@onready var hand_tracker = $HandTracker
@onready var passthrough = $CameraPassthrough
@onready var objects = $World/Objects

var fps = 0.0
var frame_count = 0
var fps_timer = 0.0

func _ready():
	for i in range(6):
		var obj = Area3D.new()
		obj.name = "Obj_" + str(i)
		obj.position = Vector3(-2.5 + i * 1.0, 1.6, -4.0)
		var mesh = MeshInstance3D.new()
		mesh.mesh = SphereMesh.new()
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color.from_hsv(i * 0.16, 0.8, 0.9)
		mesh.material_override = mat
		var col = CollisionShape3D.new()
		col.shape = SphereShape3D.new()
		col.shape.radius = 0.25
		obj.add_child(mesh)
		obj.add_child(col)
		objects.add_child(obj)

func _process(delta):
	frame_count += 1
	fps_timer += delta
	if fps_timer >= 1.0:
		fps = frame_count / fps_timer
		frame_count = 0
		fps_timer = 0.0
	var cam = "Ativa" if passthrough.camera_active else "Inativa"
	var cabeca = head_tracker.get_mode_name()
	var mao = "Detectada" if hand_tracker.hand_detected else "Não detectada"
	diagnostics.update_text("FPS: %.0f\nCâmera: %s\nCabeça: %s\nMão: %s" % [fps, cam, cabeca, mao])
	if Input.is_action_just_pressed("ui_cancel"):
		diagnostics.toggle()
