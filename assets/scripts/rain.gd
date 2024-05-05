tool
extends Node2D
export var random: bool = false
export(String, "Rain", "Pizza", "Pickle", "Cheese Stick", "Cheese Square", "Waffle") var type = "Rain"
var start_pos: Vector2
var gravity = 0.1
var motion: Vector2
var types
var graphics = Global.graphics_folder
onready var sprite = get_node("sprite")
onready var collision = get_node("area/collision")

func _ready():
	start_pos = position
	restart()
	load_all()
func _physics_process(delta):
	if !Engine.is_editor_hint():
		motion.y += gravity
		position += motion
		if position.y >= 256 * 1.5:
			if type == "Rain":
				get_node("audio").play()
			restart()

func _on_area_area_exited(area):
	if area.get_name() == "puddle":
		restart()
func _on_collision_ready():
	pass

func restart():
	position = start_pos
	motion.y = 0
	if random == true:
		position.x = (int(floor(rand_range(0, 515.999))) % 516) - 4
		position.y = (int(floor(rand_range(0, 293.999))) % 294) - 6 - 288
func load_all():
	sprite = get_node("sprite")
	collision = get_node("area/collision")
	sprite.texture = load(graphics + "items/" + type + ".png")
	collision.set_shape(RectangleShape2D.new())
	
	collision.shape.extents.x = ceil(sprite.texture.get_width() / 2.0)
	collision.shape.extents.y = ceil(sprite.texture.get_height() / 2.0)
	collision.position = collision.shape.extents
