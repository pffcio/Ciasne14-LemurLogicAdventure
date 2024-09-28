extends Control


func _on_top_left_button_pressed():
	GameController.task_complited.emit(true)


func _on_top_right_button_pressed():
	GameController.task_complited.emit(false)


func _on_bottom_left_button_pressed():
	GameController.task_complited.emit(false)


func _on_bottom_right_button_pressed():
	GameController.task_complited.emit(false)
