extends ObjectGame

class_name Bomb

onready var explosion = $Explosion/CollisionShape2D
onready var timer_start = $TimerStart
onready var timer_explosion = $TimerExplosion

func start_bomb():
	timer_start.start()

func _on_TimerStart_timeout():
	explosion.disabled = false
	timer_explosion.start()

func _on_TimerExplosion_timeout():
	GameManager.free_player_object()
	queue_free()

func _on_Explosion_body_entered(body : TileMap):
	body.remove_and_skip()
