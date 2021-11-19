extends Node

class_name ScoreManager

const SAVE_PATH = "res://scores.json"

var CustomSortScore
var save_file

var scores = Dictionary()

func _init():
	save_file = File.new()
	CustomSortScore = preload("res://Scripts/Score/CustomSortScore.gd")

func load_data():
	print("Begin loading...")
	if not save_file.file_exists(SAVE_PATH):
		print("ERROR: file does not exist (res://scores.json)")
		return 
	
	save_file.open(SAVE_PATH, File.READ)
	scores = parse_json(save_file.get_as_text())
	save_file.close()
	print("End loading")
	
func save_score(score: int, player_name: String):
	print("Begin saving...")
	if scores == null or scores.empty():
		scores[player_name + String(score)] = [score, player_name]
	else:
		var score_list = scores.values()
		score_list.sort_custom(CustomSortScore, "sort_ascending")
		var previous_score = []
		for old_score in score_list:
			if score > old_score[0]:
				previous_score = old_score
			else:
				break
		
		if previous_score != []:
			if scores.size() > 9:
				scores.erase(score_list[0][1] + String(score_list[0][0]))
			scores[player_name + String(score)] = [score, player_name]
	
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(to_json(scores))
	save_file.close()
	print("End saving")
