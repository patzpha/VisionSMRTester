extends Control

func _ready():
	setup_eyes()

func setup_eyes():
	var left = SubViewportContainer.new()
	left.name = "OlhoEsquerdo"
	left.anchors_preset = 1
	left.anchor_right = 0.5
	left.stretch_mode = SubViewportContainer.STRETCH_MODE_STRETCH
	var vp_left = SubViewport.new()
	vp_left.size = Vector2i(960, 1080)
	left.add_child(vp_left)
	add_child(left)

	var right = SubViewportContainer.new()
	right.name = "OlhoDireito"
	right.anchors_preset = 1
	right.anchor_left = 0.5
	right.anchor_right = 1.0
	right.stretch_mode = SubViewportContainer.STRETCH_MODE_STRETCH
	var vp_right = SubViewport.new()
	vp_right.size = Vector2i(960, 1080)
	right.add_child(vp_right)
	add_child(right)
