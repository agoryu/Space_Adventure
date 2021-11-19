extends Control

class_name EndGameScreen

export var title = "Congratulation"

onready var title_label = $VBoxContainer/Title
onready var scores_node = $VBoxContainer/Scores.get_children()
onready var CustomSortScore = preload("res://Scripts/Score/CustomSortScore.gd")

func _ready():
	init_scores()
	title_label.text = title
	$VBoxContainer/Menu.set_process(false)
	
func init_scores():
	GameManager.load_data()
	var scores = GameManager.get_scores().values()
	if scores.size() > 1:
		scores.sort_custom(CustomSortScore, "sort_descending")
		
	for i in range(scores.size()):
		scores_node[i].get_node("Name").text = scores[i][1]
		scores_node[i].get_node("Score").text = String(scores[i][0])


func _on_Name_validate_name():
	$VBoxContainer/Menu.set_process(true)
	init_scores()
