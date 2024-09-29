extends Control

@export var first_level: PackedScene
@export var basic_logic_level: PackedScene

func _on_start_pressed():
	$Start2.hide()
	$"Choose level".show()


func _on_quit_pressed():
	get_tree().quit()


func _on_introduction_pressed():
	get_tree().change_scene_to_packed(basic_logic_level)


func _on_through_game_pressed():
	get_tree().change_scene_to_packed(first_level)


func _on_back_pressed():
	$Start2.show()
	$"Choose level".hide()
