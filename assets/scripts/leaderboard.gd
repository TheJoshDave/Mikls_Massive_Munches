extends Node2D
onready var scores = get_node("text/score_holder")

func _ready():
	gamejolt.connect("done", self, "results")
	gamejolt.api_score_fetch(17)
	


func results(result):
	for child in scores.get_children():
		var index = int(child.name) - 1
		if result.response.scores.size() > index:
			child.text = "Name:" + result.response.scores[index].user + " Score:" + result.response.scores[index].score 
		else:
			print("break")
			break
		pass
	pass
