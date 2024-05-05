extends TileMap
onready var login = get_node("login")

func _ready():
	if Global.settings["Logged In"]:
		login.text = "New Login"
