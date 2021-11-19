extends Area2D

func _on_Area2D_body_entered(body):
	GameManager.add_bonus_score(200)
	$AnimationPlayer.play("bonus")
