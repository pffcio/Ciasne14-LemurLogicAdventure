extends Node

var main_path = "res://scenes/main_menu.tscn"
func _ready():
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file(main_path)
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		get_tree().change_scene_to_file(main_path)
