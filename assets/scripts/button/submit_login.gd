extends Label
onready var check = get_node("button")
onready var color = get_node("ColorRect")
onready var message = get_node("../../success_message")
onready var audio = get_node("audio")
var request_type: String = ""
var success: bool = false

func _ready():
	gamejolt.connect("done", self, "results")
	
	add_color_override("font_color", Global.settings["Text Color"])
	check.margin_bottom = margin_bottom - margin_top
	check.margin_right = margin_right - margin_left
	_update_text()

func _on_audio_finished():
	Global.settings["Logged In"] = false
	Global.settings["Digital"] = false
	request_type = "login"
	gamejolt.api_user_auth(Global.settings["Username"], Global.settings["User Token"])

func results(result):
	if result.response.success == "true":
		success = true
	else:
		success = false
	
	if request_type == "trophy":
		Global.settings["Digital"] = success
		request_type = ""
	
	if request_type == "login":
		Global.settings["Logged In"] = success
		request_type = "trophy"
		print(Global.load_data("Gamejolt")["Trophy"]["Digital"])
		var TrophyId = Global.load_data("Gamejolt")["Trophy"]["Digital"]["TrophyId"]
		gamejolt.api_trophy_add_achieved(Global.settings["Username"], Global.settings["User Token"], TrophyId)
	
	_update_text()

func _update_text():
	if Global.settings["Digital"]:
		message.text = "Success!!!"
		text = "Resubmit"
	elif Global.settings["Logged In"]:
		message.text = "Getting Trophy"
		text = "Please Wait"
	else:
		message.text = "Try Again"
		text = "Resubmit"

func _on_button_button_down():
	color.visible = true

func _on_button_button_up():
	color.visible = false

func _on_button_pressed():
	message.text = "Processing"
	audio.play()

func _on_box_text_changed(new_text):
	message.text = "Waiting"
	Global.settings["Logged In"] = false
	Global.settings["Digital"] = false
	_update_text()
