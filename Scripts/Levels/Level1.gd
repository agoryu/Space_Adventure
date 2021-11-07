extends Node2D

onready var coins = $Coins
onready var end = $End/CollisionShape2D

var disable_end = true

func _ready():
	GameManager.connect("all_coin_take", self, "go_back")
	GameManager.update_coin_ui(0, coins.get_child_count())
	GameManager.start_timer()

func _process(delta):
	if !disable_end:
		end.disabled = false

func go_back():
	disable_end = false

func _on_End_body_entered(body):
	print("win")
	GameManager.player_win()
