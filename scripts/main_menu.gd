extends Control

@export var first_level: PackedScene

func _on_start_pressed():
	get_tree().change_scene_to_packed(first_level)


func _on_quit_pressed():
	get_tree().quit()
