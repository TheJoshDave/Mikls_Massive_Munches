tool
extends Label
export(String) var prefix = ""
export(bool) var variable = true
export(String, 
"CHOOSE",
"score", 
"settings", 
"game_score", 
"gamejolt_data"
) var global_variable
export(String, 
"CHOOSE",
"Pizza", 
"Pickle", 
"Cheese Stick", 
"Cheese Square", 
"Waffle", 
"Bone Marrow", 
"Shot", 
"Bone", 
"Poncho", 
"Narwhale", 
"Dave", 
"Tardigrade", 
"New Tardigrades",
"Net Worth",
"Round Rank",
"Rank",
"Screen Tint",
"Text Color Open",
"Text Color",
"Roaches Open",
"Roaches",
"Start Food",
"Sound Effect Level",
"Music Level",
"Volume",
"Seconds",
"Minutes",
"Hours",
"game_mode",
"Username",
"User Token",
"User Id"
) var place_in_data
export(String) var suffix = "\n"
export(bool) var do_delay = false
export(float) var delay = 0.001
export(bool) var repeat = false

func _init():
	add_color_override("font_color", Global.settings["Text Color"])

func _ready():
	if do_delay:
		get_node("timer").start(delay)
	else:
		_text()

func _on_timer_timeout():
	_text()

func _text():
	if repeat:
		get_node("timer").start(delay)
	
	text = prefix
	
	if variable:
		text = text + str(Global.get(global_variable)[place_in_data])
		text = text + suffix
	
	add_color_override("font_color", Global.settings["Text Color"])
