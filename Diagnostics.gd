extends Control

var label: RichTextLabel
var show_diag = true

func _ready():
	label = RichTextLabel.new()
	label.bbcode_enabled = true
	label.text = "[color=#ffffff]Carregando...[/color]"
	label.modulate = Color(1, 1, 1, 0.85)
	label.scroll_active = false
	label.selection_enabled = false
	label.focus_mode = Control.FOCUS_NONE
	label.position = Vector2(10, 10)
	label.custom_minimum_size = Vector2(260, 110)
	add_child(label)

func update_text(text: String):
	if show_diag and label:
		label.text = "[color=#ffffff]%s[/color]" % text

func toggle():
	show_diag = not show_diag
	if label:
		label.visible = show_diag
