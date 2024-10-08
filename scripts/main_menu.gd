extends Control

@export var first_level = "res://scenes/levels/test_level.tscn"
@export var basic_logic_level = "res://scenes/basic_logic/lemur_tutorial_1_3.tscn"


func _ready():
	GameController.is_main_menu.emit(true)
	var exe_path = "res://scenes/Intro/Intro.exe" # Replace with the actual path to your .exe
	OS.execute(exe_path, []) 
	if !GameController.delete_bg_music_at_start:
		GameController.delete_bg_music_at_start = true
		get_tree().get_root().get_node("/root/BackgroundMusic").queue_free()

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
	$Gratification.hide()


func _on_gratification_pressed():
	$Start2.hide()
	$Gratification.show()
	check_for_rewards()

func check_for_rewards():
	if (GameController.correct_answers_true_false + GameController.correct_answers_connectors > 3):
			$Gratification/Prize1.text = "Wycieczka do ZOO"
			$Gratification/Prize2.text = "Wycieczka do Energylandii"
