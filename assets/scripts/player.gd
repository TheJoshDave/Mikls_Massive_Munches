extends KinematicBody2D
export(int) var acceleration = 400/6
export(int) var max_speed = 400
export(int) var decceleration = 400/3
export(int) var jump_force = 600
export(int) var gravity = 50
var touching_floor: bool
var touching_wall_r: bool = false
var touching_wall_l: bool = false
var motion = Vector2()
var facing = Vector2()
onready var animation = get_node("animation")
onready var body0 = get_node("0")
onready var sprite0 = body0.get_node("sprite")
onready var body1 = get_node("1")

func _ready():
	position.y = (288 - 30) - (sprite0.texture.get_height())
	position.x = (512/2) - (sprite0.texture.get_width()/2)
	
	
	var new_node: Node = body0.get_node("area_player")
	new_node.connect("area_entered", self, "area_entered", [new_node.get_parent()])
	new_node.connect("area_exited", self, "area_exited", [new_node.get_parent()])
	
	new_node = body1.get_node("area_player")
	new_node.connect("area_entered", self, "area_entered", [new_node.get_parent()])
	new_node.connect("area_exited", self, "area_exited", [new_node.get_parent()])

#gravity and input
func _physics_process(_delta):
	facing.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	facing.y = - int(Input.is_action_pressed("ui_up"))
	
	_update_animation()
	_flip_h()
	
	_acceleration_decceleration()
	_add_vertical_speed()
	_speed_cap()
	
	move_and_slide(motion)

func _acceleration_decceleration():
	if facing.x == 0:
		motion.x -= clamp(motion.x, -decceleration, decceleration) #decceleration
	else:
		motion.x += (facing.x * acceleration) #acceleration
func _add_vertical_speed():
	if touching_floor:
		motion.y = facing.y * jump_force #jump
	else:
		motion.y += gravity #gravity
func _speed_cap():
	motion.x = clamp(motion.x, 
	int(!touching_wall_l) * -max_speed, 
	int(!touching_wall_r) * max_speed) #max speed and walls
func _update_animation():
	if !touching_floor || facing == Vector2.ZERO:
		if animation.current_animation != "up":
			animation.play("up")
	else:
		animation.play("forward")
func _flip_h():
	if facing.x != 0 && body0.scale.x != facing.x: #flip h if needed
		body0.scale.x = facing.x
		body0.position.x -= facing.x * sprite0.texture.get_width()
		body1.scale.x = facing.x
		body1.position.x -= facing.x * 52

func area_entered(area, parent_node):
	if parent_node.visible:
		match area.get_name():
			"area_floor":
				touching_floor = true
			"area_wall_right":
				touching_wall_r = true
			"area_wall_left":
				touching_wall_l = true
func area_exited(area, parent_node):
	if parent_node.visible:
		match area.get_name():
			"area_floor":
				touching_floor = false
			"area_wall_right":
				touching_wall_r = false
			"area_wall_left":
				touching_wall_l = false

