extends ObjectGame

class_name Card

func _on_Card_body_entered(body : TileMap):
	body.remove_and_skip()
	GameManager.free_player_object()
	$AnimationPlayer.play("open_door")
