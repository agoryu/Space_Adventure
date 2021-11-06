extends Node2D

onready var coins = $Coins

func _ready():
	GameManager.update_coin_ui(0, coins.get_child_count())
	GameManager.start_timer()

