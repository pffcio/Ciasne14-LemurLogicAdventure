extends PathFollow2D
	
@export var speed = 105

@onready var enemy = $Enemy as Enemy

func _physics_process(delta):
	progress += speed * delta
	if progress_ratio > 0.9 && enemy != null:
		enemy.path_finished()
