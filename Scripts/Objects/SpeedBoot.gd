extends Area2D


func _on_SpeedBoot_body_entered(body : Player):
	body.bonus_speed = 200
	queue_free()
