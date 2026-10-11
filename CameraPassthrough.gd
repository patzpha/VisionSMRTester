extends Node3D

var camera_active = false
var camera_plane: MeshInstance3D

func _ready():
	start_camera()

func start_camera():
	if not Permission.request_permission("camera"):
		create_black_screen()
		return
	
	var feeds = CameraFeed.get_feeds()
	var cam = null
	for f in feeds:
		if f.position == CameraFeed.POSITION_BACK:
			cam = f
			break
	if not cam and feeds.size() > 0:
		cam = feeds[0]
	
	if cam and cam.start(0, 1920, 1080, 30):
		camera_active = true
		create_camera_plane(cam.get_texture())
	else:
		create_black_screen()

func create_camera_plane(texture: Texture2D):
	if camera_plane: camera_plane.queue_free()
	camera_plane = MeshInstance3D.new()
	var p = PlaneMesh.new()
	p.size = Vector2(16, 9)
	camera_plane.mesh = p
	var mat = StandardMaterial3D.new()
	if texture:
		mat.albedo_texture = texture
	else:
		mat.albedo_color = Color.BLACK
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_NEVER
	camera_plane.material_override = mat
	camera_plane.position = Vector3(0, 0, 5)
	add_child(camera_plane)

func create_black_screen():
	create_camera_plane(null)

func _process(delta):
	if camera_active and camera_plane:
		var feeds = CameraFeed.get_feeds()
		if feeds.size() > 0:
			var tex = feeds[0].get_texture()
			if tex and camera_plane.material_override:
				camera_plane.material_override.albedo_texture = tex
