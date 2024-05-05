extends KinematicBody2D
var motion: Vector2 = Vector2(15, 0)

func _ready():
	position.y = (288 - 30) - get_node("sprite").texture.get_height()

func _physics_process(_delta):
	move_and_slide(motion)
func _on_Roach_Area_area_exited(area):
	if area.get_name() == "area_wall_right":
		position.x = -get_node("sprite").texture.get_width()
