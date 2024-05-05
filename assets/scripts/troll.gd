tool
extends Sprite
var rotation_right: bool = true

func _process(delta):
	
	if rotation_degrees > 20:
		rotation_right = false
	elif rotation_degrees < -20:
		rotation_right = true
	
	if rotation_right:
		rotation_degrees += 1
	else:
		rotation_degrees -= 1
	
