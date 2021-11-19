extends Control

onready var coin_label = $InGame/CoinLabel
onready var timer = $Timer
onready var time_label = $InGame/Time
onready var message_label = $Message
onready var score_label = $InGame/ScoreLabel
onready var menu = $Menu
onready var animation = $AnimationPlayer

onready var EndGameScreen = preload("res://Scenes/Screens/EndGameScreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("update_coin", self, 'update_coin')
	GameManager.connect("start_timer", self, 'start_timer')
	GameManager.connect("player_win", self, 'player_win')
	GameManager.connect("update_score", self, 'update_score')
	GameManager.connect("all_coin_take", self, "go_back_message")
	animation.play("instruction")

func _physics_process(delta):
	var time_value = timer.time_left
	var minute = time_value / 60
	var second = fmod(time_value, 60)
	if second < 10:
		time_label.text = "%d : 0%d" % [minute, second]
	else:
		time_label.text = "%d : %d" % [minute, second]
		
	if time_value <= 10 and !timer.is_stopped() and not animation.is_playing():
		animation.play("time")

func update_coin(coin : int, total_coin : int):
	coin_label.text = "%s / %s" % [coin, total_coin]
	
func start_timer():
	timer.start()
	
func player_win():
	timer.paused = true
	GameManager.add_time_to_score(timer.time_left)
	display_end_game('CONGRATULATION')

func _on_Timer_timeout():
	GameManager.player_loose()
	display_end_game('GAME OVER')
	
func update_score(score : int):
	score_label.text = str(score)
	
func go_back_message():
	animation.play("end")
	
func display_end_game(msg: String):
	var end_game_screen = EndGameScreen.instance() as EndGameScreen
	end_game_screen.title = msg
	self.get_parent().add_child(end_game_screen)
	$InGame.visible = false
	$Alert.visible = false
