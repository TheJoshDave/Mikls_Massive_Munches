tool
extends Node2D
export var wanted_amt: int
var left_amt: int
export var random: bool = false
export(String, "Rain", "Pizza", "Pickle", "Cheese Stick", "Cheese Square", "Waffle") var type = "Rain"
var path: String = "res://assets/objects/rain.tscn"

func _ready():
	left_amt = wanted_amt
	gen()
	

func timeout():
	var new = load(path).instance()
	new.random = random
	new.type = type
	add_child(new)
	get_node("timer" + str(left_amt)).queue_free()
	left_amt -= 1
	gen()

func gen():
	if left_amt > 1:
		var timer = Timer.new()
		add_child(timer)
		timer.connect("timeout", self, "timeout")
		timer.name = "timer" + str(left_amt)
		timer.start(rand_range(0, 0.01))


