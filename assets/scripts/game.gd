extends Node
var object
var seconds: int = 0
var minutes: int = 1
var hours: int = 0
var done: bool = false
var song_played: bool = false
var game_data = Global.load_data("Food")["Game"]
const roach: String = "res://assets/objects/roach.tscn"
const player: String = "res://assets/objects/player.tscn"
const food_object: String = "res://assets/objects/food/food_all.tscn"
const menu: String = "res://assets/scenes/menu.tscn"
onready var wall_left = get_node("background/area_wall_left/wall_left")
onready var audio = get_node("audio")
onready var back = get_node("back")
onready var front = get_node("front")
onready var timer_text = front.get_node("timer")
onready var timer = get_node("timer")
onready var theme = get_node("theme")
onready var food = back.get_node("food")

func _init():
	for key in Global.game_score:
		Global.game_score[key] = 0
	Global.game_score["game_mode"] = true
	
	seconds = Global.settings["Seconds"]
	minutes = Global.settings["Minutes"]
	hours = Global.settings["Hours"]

#start
func _ready():
	_make_player()
	_roach_gen(Global.settings["Roaches"])
	_gen(Global.settings["Start Food"])
	timer.start(seconds + ((minutes + (hours * 60)) * 60))
	done = true


#player
func _make_player():
	object = preload(player).instance()
	back.add_child(object)

#roach
func _roach_gen(number):
	if number > 0:
		var roach_width: int = 14
		var space_size = (512 + (wall_left.shape.extents.x) + (roach_width))/number
		for i in range(number):
			object = preload(roach).instance()
			object.position.x = space_size * i
			front.add_child(object)

#food
func _gen(amount : int):
	for i in range(amount):
		object = preload(food_object).instance()
		object.controller = self
		food.add_child(object)

#timer
func _process(delta):
	if done:
		var time_left = int(timer.get_time_left())
		var seconds:int = floor(time_left % 60)
		var minutes:int = floor((time_left % 3600) / 60)
		var hours:int = floor((time_left % (3600 * 24)) / 3600)
		
		if hours > 0:
			timer_text.text = str(hours) + ":"
			if minutes >= 10:
				timer_text.text += str(minutes) + ":"
			else:
				timer_text.text += "0" + str(minutes) + ":"
			if seconds >= 10:
				timer_text.text += str(seconds)
			else:
				timer_text.text += "0" + str(seconds)
		else:
			if minutes > 0:
				timer_text.text = str(minutes) + ":"
				if seconds >= 10:
					timer_text.text += str(seconds)
				else:
					timer_text.text += "0" + str(seconds)
			else:
				if seconds > 0:
					timer_text.text = str(seconds)
				else:
					get_tree().change_scene(menu)
		
		if timer.get_time_left() <= 2 && !audio.playing:
			audio.play() #throw up
		if timer.get_time_left() <= 36 && !song_played:
			song_played = true
			theme.play() #end song
