extends ObjectGame

class_name Bomb

onready var explosion = $Explosion/CollisionShape2D
onready var timer_start = $TimerStart
onready var animation = $AnimationPlayer

func start_bomb():
	animation.play("calculation")

func explode():
	explosion.disabled = false
	GameManager.free_player_object()

func _on_Explosion_body_entered(body : TileMap):
	body.remove_and_skip()
