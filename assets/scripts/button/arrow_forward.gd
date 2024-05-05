extends Node2D
export(String, FILE, "*.tscn") var path
export(String, FILE, "*.png") var normal_frame
export(String, FILE, "*.png") var click_frame
onready var frame = get_node("sprite")
onready var button = get_node("button")

func _ready():
	frame.texture = load(normal_frame)
	button.margin_right = frame.texture.get_width()
	button.margin_bottom = frame.texture.get_height()


func _on_ToolButton_pressed():
	get_tree().change_scene(path)

func _on_ToolButton_button_down():
	frame.texture = load(click_frame)

func _on_ToolButton_button_up():
	frame.texture = load(normal_frame)
