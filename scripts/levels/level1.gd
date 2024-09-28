extends Node2D
class_name Level

@export var elements: int
@export var timeout_in_seconds: float

@onready var path2d = $Path2D as Path2D
@onready var hearts = $Hearts as Node2D

signal enemy_finished(enemy: Enemy)

var enemy = preload("res://scenes/enemy.tscn")

var iteration = 0
var counter = 1
var timer = Timer.new()

func _ready():
	enemy_finished.connect(_on_enemy_finished)

func start() -> void:
	print("START")
	iteration += 1
	if iteration == 3:
		iteration = 1
	elements *= iteration
	if iteration % 2 == 0:
		timeout_in_seconds -= 0.1
	timer.wait_time = timeout_in_seconds
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()

func _on_timeout() -> void:
	if counter >= elements:
		counter = 1
		timer.stop()
		timer.timeout.disconnect(_on_timeout)
		remove_child(timer)
		return
	
	path2d.add_child(enemy.instantiate())
	counter += 1

func _on_enemy_finished(enemy: Enemy):
	var childs = hearts.get_children()
	if childs.size() > 0:
		childs.back().queue_free()
	enemy.queue_free()
	
