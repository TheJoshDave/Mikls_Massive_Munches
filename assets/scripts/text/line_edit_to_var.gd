extends LineEdit
export(String) var global_variable
export(String) var place_in_data

func _ready():
	text = Global.get(global_variable)[place_in_data]

func _on_box_text_changed(new_text):
	Global.get(global_variable)[place_in_data] = new_text
