tool
extends HSlider
export(String) var data_set = "settings"
export(String) var part_of_data = "Screen Tint"
export(bool) var red = false
export(bool) var green = false
export(bool) var blue = false

func _ready():
	if red:
		value = Global.get(data_set)[part_of_data].r
	elif green:
		value = Global.get(data_set)[part_of_data].g
	elif blue:
		value = Global.get(data_set)[part_of_data].b
	else:
		value = Global.get(data_set)[part_of_data]

func _on_brightness_value_changed(value):
	if red:
		Global.get(data_set)[part_of_data].r = value
	elif green:
		Global.get(data_set)[part_of_data].g = value
	elif blue:
		Global.get(data_set)[part_of_data].b = value
	else:
		Global.get(data_set)[part_of_data] = value


func _on_sound_value_changed(value):
	Global.settings["Sound Effect Level"] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("effects"), Global.settings["Sound Effect Level"])


func _on_music_value_changed(value):
	Global.settings["Music Level"] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), Global.settings["Music Level"])
