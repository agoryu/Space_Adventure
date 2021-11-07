extends Node

signal move_cam
signal update_coin
signal update_score
signal start_timer
signal player_win
signal free_player_object
signal all_coin_take

onready var tree = get_tree()

const SCORE_VALUE : int = 100

var score = 0 setget set_score
var coin = 0
var total_coin = 10000

func move_cam(direction : Vector2):
	emit_signal("move_cam", direction)
	
func update_score_with_coin():
	self.score += SCORE_VALUE
	coin += 1
	update_coin_ui(coin, total_coin)
	
	if coin == total_coin:
		emit_signal("all_coin_take")
	
func update_coin_ui(coin_value : int, total_coin_value : int):
	if total_coin == 10000:
		total_coin = total_coin_value
	emit_signal("update_coin", coin_value, total_coin_value)
	
func start_timer():
	emit_signal("start_timer")
	
func player_loose():
	tree.paused = true
	
func set_score(value : int):
	score = value
	emit_signal("update_score", score)
	
func add_time_to_score(time : int):
	self.score += time * 10
	
func add_bonus_score(value : int):
	self.score += value
	
func free_player_object():
	emit_signal("free_player_object")
	
func start_game():
	score = 0
	coin = 0
	tree.paused = false
	tree.change_scene("res://Scenes/Levels/Level1.tscn")
	
func player_win():
	tree.paused = true
	emit_signal("player_win")
