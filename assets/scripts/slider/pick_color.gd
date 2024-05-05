extends ColorPickerButton

func _on_ColorPickerButton_color_changed(color):
	Global.settings["Text Color"] = color

func _on_ColorPickerButton_picker_created():
	color = Global.settings["Text Color"]
	get_child(0).margin_bottom = 50

