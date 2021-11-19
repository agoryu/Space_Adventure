extends Control

class_name Letter

export var anim : bool = false
onready var label : Label = $Label

func _process(delta):
	if anim and !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("anim")
