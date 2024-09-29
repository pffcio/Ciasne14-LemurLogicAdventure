extends Node2D
class_name Level

@export var elements: int
@export var timeout_in_seconds: float

@onready var path2d = $Path2D as Path2D
@onready var hearts = $Hearts as Node2D

signal enemy_finished(enemy: Enemy)

var enemies = {
	0: preload("res://scenes/enemy.tscn"),
	1: preload("res://scenes/enemy_2.tscn"),
	2: preload("res://scenes/enemy_3.tscn"),
	3: preload("res://scenes/enemy_4.tscn"),
}
var enemies_per_iteration = {
	1: [0,0,0,0],
	2: [0,0,1,1,1,1],
	3: [1,1,2,2,2,2,2,2],
	4: [2,2,2,3,3,3,3,3],
	5: [3,3,3,3,3,3,3,3]
}
var iteration = 0
var counter = 0
var timer = Timer.new()

func _ready():
	enemy_finished.connect(_on_enemy_finished)

func start() -> void:
	print("START")
	iteration += 1
	if iteration == 6:
		iteration = 1
	timer.wait_time = timeout_in_seconds
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()

func _on_timeout() -> void:
	var enemies_for_iteration = enemies_per_iteration[iteration]
	if counter >= enemies_for_iteration.size():
		counter = 0
		timer.stop()
		timer.timeout.disconnect(_on_timeout)
		remove_child(timer)
		return
	
	path2d.add_child(enemies[enemies_for_iteration[counter]].instantiate())
	counter += 1

func _on_enemy_finished(enemy: Enemy):
	var childs = hearts.get_children()
	if childs.size() > 0:
		childs.back().queue_free()
	enemy.queue_free()
	
