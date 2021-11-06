extends Control

onready var coin_label = $CoinLabel
onready var timer = $Timer
onready var time_label = $Time
onready var message_label = $Message
onready var score_label = $ScoreLabel
onready var menu = $Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("update_coin", self, 'update_coin')
	GameManager.connect("start_timer", self, 'start_timer')
	GameManager.connect("player_win", self, 'player_win')
	GameManager.connect("update_score", self, 'update_score')

func _physics_process(delta):
	var time_value = timer.time_left
	var minute = time_value / 60
	var second = fmod(time_value, 60)
	time_label.text = "%d : %d" % [minute, second]

func update_coin(coin : int, total_coin : int):
	coin_label.text = "%s / %s" % [coin, total_coin]
	
func start_timer():
	timer.start()
	
func player_win():
	timer.paused = true
	GameManager.add_time_to_score(timer.time_left)
	message_label.text = 'CONGRATULATION'
	message_label.set("custom_colors/font_color", Color(22.0/255.0, 159.0/255.0, 47.0/255.0, 1))

func _on_Timer_timeout():
	GameManager.player_loose()
	message_label.text = 'GAME OVER'
	message_label.set("custom_colors/font_color", Color(247.0/255.0, 10.0/255.0, 10.0/255.0, 1))
	menu.visible = true
	
func update_score(score : int):
	score_label.text = str(score)
