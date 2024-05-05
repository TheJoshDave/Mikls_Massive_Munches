extends Node2D
export(String, FILE, "*.tscn") var scoring = "res://assets/scenes/popups/scoring.tscn"
export(String, FILE, "*.tscn") var save = "res://assets/scenes/popups/save.tscn"

func _ready():
	if Global.game_score.game_mode == true:
		Global.game_score.game_mode = false
		
		#adds game scores to global
		for key in Global.game_score:
			if key != "game_mode":
				Global.score[key] += Global.game_score[key]
		
		
		
		
		
		var score_rank: float 
		score_rank = _add_score_rank(1, "Pizza")
		score_rank += _add_score_rank(2, "Pickle")
		score_rank += _add_score_rank(3, "Cheese Stick")
		score_rank += _add_score_rank(4, "Cheese Square")
		score_rank += _add_score_rank(5, "Waffle")
		var score_name = str(score_rank)+"_tardigrade_points"
		score_rank *= 1000
		
		var extra_data: String
		for key in Global.score:
			extra_data += str(key) + ":" + str(Global.score[key]) + "___"
		extra_data =extra_data.replace(" ", "_")
		
		
		if Global.settings["Logged In"]:
			gamejolt.api_score_add(score_name, score_rank, Global.settings["Username"], Global.settings["User Token"], gamejolt.emptyS, extra_data, 510503)
		
		var new = load(save).instance()
		add_child(new)
		new = load(scoring).instance()
		add_child(new)

func _add_score_rank(price : int, food : String):
	#returns amount of tardigrade points for this round
	return (price * Global.game_score[food]) + (pow(price * 0.1, 2) * Global.game_score[food])
