extends Node3D

var hand_detected = false
var hand_position = Vector3(0, 0, -0.5)
var pinching = false
var fist_closed = false

var skin_lower = Color(0.55, 0.38, 0.28)
var skin_upper = Color(0.85, 0.72, 0.62)

func _ready():
	pass

func update_from_camera(image: Image):
	# Detecção simplificada por cor — para uso básico
	# Para MediaPipe real, precisaria de biblioteca externa
	hand_detected = false
	pass

func is_pinching() -> bool:
	return pinching

func is_fist_closed() -> bool:
	return fist_closed

func get_hand_position() -> Vector3:
	return global_position + hand_position
