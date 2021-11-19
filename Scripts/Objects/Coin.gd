extends Node2D

func _on_Area2D_body_entered(body):
	GameManager.update_score_with_coin()
	$AnimationPlayer.play("get_coin")
