extends Sprite2D

@export var target_scale: Vector2 = Vector2(0.7, 0.7) 

@export var scaling_speed: float = 0.5 

func _process(delta: float) -> void:
	scale = scale.lerp(target_scale,scaling_speed * delta)
