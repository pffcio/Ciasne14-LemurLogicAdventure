extends Node2D

@export var elements: int
@export var timeout_in_seconds: float

@onready var path2d = $Path2D as Path2D

var enemy = preload("res://scenes/enemy.tscn")

var counter = 1
var timer = Timer.new()

func _ready() -> void:
	timer.wait_time = timeout_in_seconds
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()

func _on_timeout() -> void:
	if counter == elements:
		timer.stop()
		timer.queue_free()
		return
	
	path2d.add_child(enemy.instantiate())
	counter += 1
	
