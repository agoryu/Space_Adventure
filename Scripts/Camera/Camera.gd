extends Node2D

onready var view = get_viewport_rect()
onready var camera = $Camera 
onready var timer = $Timer

func _ready():
	GameManager.connect("move_cam", self, "move")
	
func move(direction : Vector2):
	if timer.is_stopped():
		camera.position += direction * view.size
		timer.start()

