extends Node2D

onready var coins = $Coins
onready var end = $End/CollisionShape2D
onready var bombs = $Bombs
onready var bomb_timer = $Bombs/Timer

onready var bomb_object = preload("res://Scenes/Objects/Bomb.tscn")

var disable_end = true

func _ready():
	GameManager.connect("all_coin_take", self, "go_back")
	GameManager.update_coin_ui(0, coins.get_child_count())
	GameManager.start_timer()

func _process(delta):
	if !disable_end:
		end.disabled = false
	
	if bombs.get_child_count() == 1 and bomb_timer.is_stopped():
		print("create bomb")
		var bomb = bomb_object.instance() as Bomb
		bombs.add_child(bomb)
		bomb_timer.start()

func go_back():
	disable_end = false

func _on_End_body_entered(body):
	print("win")
	GameManager.player_win()

func _on_Player_take_bomb():
	bomb_timer.start()
