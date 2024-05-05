extends Label
export(String, FILE, "*.tscn") var path
onready var check = get_node("button")
onready var color = get_node("color")
onready var audio = get_node("audio")

func _ready():
	add_color_override("font_color", Global.settings["Text Color"])
	check.margin_bottom = margin_bottom - margin_top
	check.margin_right = margin_right - margin_left

func _on_audio_finished():
	
	get_tree().change_scene(path)

func _on_button_button_down():
	color.visible = true

func _on_button_button_up():
	color.visible = false

func _on_button_pressed():
	audio.play()
