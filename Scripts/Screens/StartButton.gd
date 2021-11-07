extends Button

export var title : String = "Start"

func _on_Start_button_up():
	GameManager.start_game()
