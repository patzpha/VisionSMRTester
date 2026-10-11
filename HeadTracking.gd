extends Node3D

var has_gyro = false
var has_accel = false
var rotation_speed = 1.0
var current_pitch = 0.0
var current_yaw = 0.0
var last_touch_pos = Vector2.ZERO
var is_dragging = false

@onready var cam_left = $CameraLeft
@onready var cam_right = $CameraRight

func _ready():
	check_sensors()
	setup_cameras()

func check_sensors():
	has_gyro = Input.is_sensor_enabled(Input.SENSOR_GYROSCOPE) or Input.get_sensor_count(Input.SENSOR_GYROSCOPE) > 0
	has_accel = Input.is_sensor_enabled(Input.SENSOR_ACCELEROMETER) or Input.get_sensor_count(Input.SENSOR_ACCELEROMETER) > 0
	
	if has_gyro:
		Input.enable_sensor(Input.SENSOR_GYROSCOPE, 60)
	elif has_accel:
		Input.enable_sensor(Input.SENSOR_ACCELEROMETER, 60)
		Input.enable_sensor(Input.SENSOR_MAGNETOMETER, 30)

func setup_cameras():
	if not $CameraLeft:
		var l = Camera3D.new()
		l.name = "CameraLeft"
		l.fov = 90.0
		l.position.x = -0.0325
		add_child(l)
		cam_left = l
	if not $CameraRight:
		var r = Camera3D.new()
		r.name = "CameraRight"
		r.fov = 90.0
		r.position.x = 0.0325
		add_child(r)
		cam_right = r

func get_mode_name() -> String:
	if has_gyro: return "Giroscópio"
	if has_accel: return "Acelerômetro"
	return "Toque"

func _process(delta):
	if has_gyro:
		var gyro = Input.get_sensor_reading(Input.SENSOR_GYROSCOPE)
		current_yaw -= gyro.z * rotation_speed * delta
		current_pitch -= gyro.x * rotation_speed * delta
	elif has_accel:
		var accel = Input.get_sensor_reading(Input.SENSOR_ACCELEROMETER)
		current_yaw = -Math.atan2(accel.x, accel.z)
		current_pitch = Math.atan2(accel.y, sqrt(accel.x*accel.x + accel.z*accel.z))
	else:
		pass
	
	rotation_degrees = Vector3(
		rad_to_deg(current_pitch),
		rad_to_deg(current_yaw),
		0
	)

func rad_to_deg(r: float) -> float:
	return r * 180.0 / PI

func _input(event):
	if not has_gyro and not has_accel:
		if event is InputEventMouseButton and event.pressed:
			last_touch_pos = event.position
			is_dragging = true
		elif event is InputEventMouseButton and not event.pressed:
			is_dragging = false
		elif event is InputEventMouseMotion and is_dragging:
			var delta_pos = event.position - last_touch_pos
			current_yaw += delta_pos.x * 0.003
			current_pitch += delta_pos.y * 0.003
			last_touch_pos = event.position
