tool
extends Node
const save_version: String = "0.3.0" #save version
const save_path = "user://save_data" #save path
const brightness_script = "res://assets/scripts/brightness.gd"
const graphics_folder = "res://assets/graphics/"
const audio_folder = "res://assets/audio/"
const data_folder = "res://assets/data/"
var screen = Vector2() #Screen size

var score = {
	"Tardigrade" : 0,
	"New Tardigrades" : 0,
	"Net Worth" : 0,
	"Round Rank" : 0,
	"Rank" : 0,
} #Scoring variables

var settings = {
	"Text Color" : Color("000000")
} #contains settings and gamejolt data

var game_score = {
	"game_mode" : false,
}


func _init():
	load_keys_from_file("settings", "Default", "Setting") #puts keys in settings
	load_keys_from_file("game_score", "Food", "Game", true) #puts keys in game_score
	load_keys_from_file("score", "Food", "Store", true) #puts score variables in score
	
	load_save()
	randomize() #Generate a new seed based on time
	
	screen = OS.get_screen_size() #Set Vector2 screen to the size of the screen
	build_brightness() #make screen tint for brightness
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED) #Set mouse visible and cannot leave screen
	update_sound_settings()
	build_music("res://assets/audio/song.wav", "music") #make global music player
	build_music("res://assets/audio/static.wav", "Master") #make static

func update_sound_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), settings["Volume"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("effects"), settings["Sound Effect Level"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), settings["Music Level"])
func build_music(song_file : String, where : String):
	var build = AudioStreamPlayer.new()
	build.stream = load(song_file)
	build.play()
	build.set_name("music_player")
	build.bus = where
	add_child(build)
func build_brightness():
	var build = CanvasModulate.new()
	build.set_name("screen_tint")
	build.set_script(preload(brightness_script))
	add_child(build)
func load_save():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			for keys_1 in data:
				if get(keys_1):
					for keys_2 in data[keys_1]:
						get(keys_1)[keys_2] = data[keys_1][keys_2]
	file.close()
func load_keys_from_file(where : String, file : String, section : String, make_zero : bool = false):
	var new_data = load_data(file)[section]
	for key in new_data:
		if make_zero:
			get(where)[key] = 0
		else:
			get(where)[key] = new_data[key][section + "Value"]

func load_data(file):
	var new_file = File.new()
	new_file.open(data_folder + file + ".json", File.READ)
	var file_data = JSON.parse(new_file.get_as_text())
	new_file.close()
	return file_data.result
"""
Food : Game / Store
Gamejolt : Trophy / Score
Default : Setting
"""
