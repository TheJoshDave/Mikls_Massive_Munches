extends Node
onready var audio = get_node("audio")

func _ready():
	var data = {
		"version" : Global.save_version,
		"score" : Global.score,
		"settings" : Global.settings,
	}
	var file = File.new()
	var error = file.open(Global.save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
	file.close()
	
	if Global.settings["Logged In"]:
		gamejolt.api_score_add(str(Global.score["Net Worth"] * 1000), Global.score["Net Worth"] * 1000, Global.settings["Username"], Global.settings["User Token"], gamejolt.emptyS, gamejolt.emptyS, 507785)
	audio.play()
