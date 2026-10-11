extends Area3D

var base_color = Color.WHITE
var highlight_color = Color(1, 1.2, 1.5, 1.0)
var is_held = false

func _ready():
	if get_child_count() > 0 and get_child(0) is MeshInstance3D:
		var mat = get_child(0).material_override
		if mat:
			base_color = mat.albedo_color

func set_highlight(enabled: bool):
	if get_child_count() > 0 and get_child(0) is MeshInstance3D:
		var mesh = get_child(0)
		var mat = mesh.material_override.duplicate()
		if enabled:
			mat.emission = Color(0.3, 0.6, 1.0)
			mat.emission_energy = 1.2
		else:
			mat.emission = Color.BLACK
			mat.emission_energy = 0.0
		mesh.material_override = mat
