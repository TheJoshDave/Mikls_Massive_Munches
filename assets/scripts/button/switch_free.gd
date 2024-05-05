extends Label
export(String, "switch", "free") var button_type = "switch"
onready var check = get_node("button")
onready var color = get_node("color")
onready var audio = get_node("audio")
export(NodePath) var show_free
export(NodePath) var hide

func _ready():
	add_color_override("font_color", Global.settings["Text Color"])
	check.margin_bottom = margin_bottom - margin_top
	check.margin_right = margin_right - margin_left

func _on_audio_finished():
	if button_type == "switch":
		get_node(show_free).visible = true
		get_node(hide).visible = false
	elif button_type == "free":
		get_node(show_free).queue_free()

func _on_button_button_down():
	color.visible = true
func _on_button_button_up():
	color.visible = false
func _on_button_pressed():
	audio.play()
