extends Control

signal validate_name

onready var letters_tab = $VBoxContainer/Letters.get_children()
onready var timer = $Timer

onready var letter = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

var label_selected = 0
var letter_selected = 0
var player_name = ["A", "A", "A"]

var is_finished : bool = false

func _ready():
	letters_tab[label_selected].anim = true

func _process(delta):
	if timer.is_stopped():
		if Input.is_action_pressed("ui_accept"):
			letters_tab[label_selected].anim = false
			player_name[label_selected] = letters_tab[label_selected].label.text
			if label_selected + 1 < 3:
				label_selected += 1
				letters_tab[label_selected].anim = true
				letter_selected = 0
			else:
				GameManager.add_score(player_name[0] + player_name[1] + player_name[2])
				is_finished = true
			timer.start()
		if Input.is_action_pressed("ui_cancel"):
			letters_tab[label_selected].anim = false
			if label_selected - 1 >= 0:
				label_selected -= 1
				letters_tab[label_selected].anim = true
				letter_selected = letter.find(letters_tab[label_selected].label.text)
			timer.start()
			
		if Input.is_action_pressed("ui_up"):
			letter_selected = fmod(letter_selected + 1, 26) 
			letters_tab[label_selected].label.text = letter[letter_selected]
			letters_tab[label_selected].grab_focus()
			timer.start()
		if Input.is_action_pressed("ui_down"):
			letter_selected = fmod(letter_selected - 1, 26) 
			letters_tab[label_selected].label.text = letter[letter_selected]
			letters_tab[label_selected].grab_focus()
			timer.start()


func _on_Timer_timeout():
	if is_finished:
		emit_signal("validate_name")
		self.set_process(false)
