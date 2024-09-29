extends Control

@export var first_level = "res://scenes/levels/test_level.tscn"
@export var basic_logic_level = "res://scenes/basic_logic/lemur_tutorial_1_3.tscn"


func _ready():
	GameController.is_main_menu.emit(true)


func _on_start_pressed():
	$Start2.hide()
	$"Choose level".show()


func _on_quit_pressed():
	get_tree().quit()


func _on_introduction_pressed():
	GameController.is_main_menu.emit(false)
	get_tree().change_scene_to_file(basic_logic_level)


func _on_through_game_pressed():
	GameController.is_main_menu.emit(false)
	get_tree().change_scene_to_file(first_level)


func _on_back_pressed():
	$Start2.show()
	$"Choose level".hide()
