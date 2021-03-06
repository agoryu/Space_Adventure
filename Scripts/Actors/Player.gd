extends KinematicBody2D

class_name Player

signal take_bomb

onready var hand = $Hand
onready var audio = $AudioStreamPlayer2D
export var speed : int = 300

var bonus_speed : int = 0
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

var object = null
var change_object : bool = false

func _ready():
	GameManager.connect("free_player_object", self, "free_object")

func _physics_process(delta):
	move_player(delta)
	manage_object()
	
func move_player(delta):
	direction = Vector2.ZERO
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	elif Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
	elif Input.is_action_pressed("ui_up"):
		direction.y = -1
		
	velocity = direction.normalized() * (speed + bonus_speed) * delta
	move_and_collide(velocity)
	hand.position = direction * 16

func _on_VisibilityNotifier2D_screen_exited():
	GameManager.move_cam(direction)

func _on_Area2D_area_entered(area):
	if area is ObjectGame:
		audio.play()
		object = area
		change_object = true
		
		if area is Bomb:
			emit_signal("take_bomb")
		
func manage_object():
	if change_object:
		object.get_parent().remove_child(object)
		hand.add_child(object)
		object.position = Vector2.ZERO
		change_object = false
		
	if object != null and object is Bomb and Input.is_action_pressed("ui_accept"):
		var bomb : Bomb = object as Bomb
		bomb.set_as_toplevel(true)
		bomb.global_position = hand.global_position
		bomb.start_bomb()
		
	if bonus_speed > 0:
		$Shadow.position = direction.normalized() * -1 * 20
		
func free_object():
	object = null
