extends Node2D

func _ready():
	if Global.settings["Text Color Open"]:
		get_node("front/settings/roaches/roaches").editable = true
	else:
		get_node("front/settings/roaches/roaches").editable = false
	
	if Global.settings["Roaches Open"]:
		get_node("front/settings/text_color/R/red").editable = true
		get_node("front/settings/text_color/G/green").editable = true
		get_node("front/settings/text_color/B/blue").editable = true
	else:
		get_node("front/settings/text_color/R/red").editable = false
		get_node("front/settings/text_color/G/green").editable = false
		get_node("front/settings/text_color/B/blue").editable = false
	
	pass
