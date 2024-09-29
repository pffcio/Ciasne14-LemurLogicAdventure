extends Sprite2D

@export var target_position: Vector2 = Vector2(0, 0) # Desired target position
@export var move_speed: float = 300.0 # Speed in pixels per second

func _process(delta: float) -> void:
	# Move the sprite towards the target position over time
	position = position.move_toward(target_position, move_speed * delta)
