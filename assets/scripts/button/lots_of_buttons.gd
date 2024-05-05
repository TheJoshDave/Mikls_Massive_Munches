tool
extends Label
export(String, "popup", "scene") var button_type = "popup"
export(String, FILE, "*.tscn") var path
export var repeat: bool = false
onready var check = get_node("button")
onready var color = get_node("color")
onready var audio = get_node("audio")
onready var root = get_node("/root")

func _ready():
	if repeat:
		set_physics_process(true)
	else:
		set_physics_process(false)
		add_color_override("font_color", Global.settings["Text Color"])
	check.margin_bottom = margin_bottom - margin_top
	check.margin_right = margin_right - margin_left

func _on_audio_finished():
	if button_type == "scene":
		get_tree().change_scene(path)
	elif button_type == "popup":
		var new = load(path).instance()
		root.add_child(new)

func _physics_process(delta):
	add_color_override("font_color", Global.settings["Text Color"])

func _on_button_button_down():
	color.visible = true
func _on_button_button_up():
	color.visible = false
func _on_button_pressed():
	audio.play()
