extends Node
onready var body = get_node("body")
onready var sprite = body.get_node("sprite")
onready var audio = body.get_node("audio")
onready var collision = body.get_node("area/collision")
onready var controller: Node
var motion = Vector2()
var type: String

func _ready():
	_new_food()

func _on_area_area_entered(area):
	match area.get_name():
		"area_player":
			body.hide()
			audio.stream = load(Global.audio_folder + controller.game_data[type].FoodPickup + ".wav")
			Global.game_score[type] += 1
			audio.play()
		"area_floor":
			body.hide()
			audio.stream = load(Global.audio_folder + controller.game_data[type].FoodGround + ".wav")
			audio.play()

func _physics_process(_delta):
	body.move_and_slide(motion)

func _on_audio_finished():
	_new_food()

func _new_food():
	var random: float
	var chance: float
	var food: String
	
	#choose food
	for key in controller.game_data:
		chance += controller.game_data[key].FoodChance
	random = rand_range(0.0, chance)
	chance = 0
	for key in controller.game_data:
		chance += controller.game_data[key].FoodChance
		if random < chance:
			food = key
			break
	
	
	if type != food:
		type = food
		sprite.texture = load(Global.graphics_folder + "items/" + food + ".png")
		motion.y = controller.game_data[food].FoodSpeed
		collision.set_shape(RectangleShape2D.new())
		
		collision.shape.extents.x = ceil(sprite.texture.get_width() / 2.0)
		collision.shape.extents.y = ceil(sprite.texture.get_height() / 2.0)
		collision.position = collision.shape.extents
	body.position.y = -sprite.texture.get_height()
	body.position.x = (randi() % ((128 * 4) - 16))
	body.show()
	

