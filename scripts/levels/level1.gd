extends Node2D
class_name Level

@export var elements: int
@export var timeout_in_seconds: float

@export var level: int = 1

@onready var path2d = $Path2D as Path2D
@onready var hearts = $Hearts as Node2D
@onready var game_ui = $game_ui

signal enemy_finished(enemy: Enemy)
signal enemy_died

var enemies = {
	0: preload("res://scenes/enemy.tscn"),
	1: preload("res://scenes/enemy_2.tscn"),
	2: preload("res://scenes/enemy_3.tscn"),
	3: preload("res://scenes/enemy_4.tscn"),
}
var enemies_per_iteration = {
	1: {
		1: [0,0,0,0],
		2: [0,0,1,1,1,1],
		3: [1,1,2,2,2,2,2,2],
		4: [2,2,2,3,3,3,3,3],
		5: [3,3,3,3,3,3,3,3]
	},
	2: {
		1: [1,1,1,1,1],
		2: [0,0,1,1,0,1],
		3: [3,1,2,0,2,2,2,2],
		4: [2,1,2,3,3,3,3,0],
		5: [3,3,3,3,3,3,3,3,3]
	}
}

var level_scenes = {
	2: "res://scenes/levels/test_level2.tscn"
}

var ongoing = false
var iteration = 0
var counter = 0
var timer = Timer.new()

func _ready():
	enemy_finished.connect(_on_enemy_finished)
	GameController.is_prepare.emit(true)
	GameController.is_prepare_val = true
	enemy_died.connect(_on_enemy_died)
	game_ui.next_level.connect(_on_next_level)

func start() -> void:
	GameController.is_prepare.emit(false)
	GameController.is_wave.emit(true)
	GameController.is_wave_val = true
	GameController.is_prepare_val = false
	print("START")
	iteration += 1
	if iteration == 6:
		var index = level+1
		if level_scenes.has(index) == false:
			print("NIe ISTNIEJE")
			return
		var scene = level_scenes[index]
		get_tree().change_scene_to_file(scene)
		return
	timer.wait_time = timeout_in_seconds
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()
	game_ui.set_play_disabled(true)


func _on_timeout() -> void:
	var enemies_for_iteration = enemies_per_iteration[level][iteration]
	if counter >= enemies_for_iteration.size():
		counter = 0
		timer.stop()
		timer.timeout.disconnect(_on_timeout)
		remove_child(timer)
		return

	path2d.add_child(enemies[enemies_for_iteration[counter]].instantiate())
	counter += 1

func _on_enemy_finished(enemy: Enemy):
	## TODO check hearts and if player dies
	var childs = hearts.get_children()
	if childs.size() > 0:
		childs.back().queue_free()
	enemy_died.emit()
	enemy.get_parent().queue_free()

func _on_enemy_died():
	if hearts.get_child_count() != 0 && path2d.get_child_count() == 1 && timer.is_stopped():
		game_ui.set_play_disabled(false)
		GameController.is_wave.emit(false)
		GameController.is_prepare.emit(true)
		GameController.is_wave_val = false
		GameController.is_prepare_val = true
	if iteration == 5 && path2d.get_child_count() == 1 && hearts.get_child_count() != 0 && timer.is_stopped():
		game_ui.show_next_level()


func _on_next_level():
	var index = level+1
	if level_scenes.has(index) == false:
		print("NIe ISTNIEJE")
		return
	var scene = level_scenes[index]
	get_tree().change_scene_to_file(scene)
