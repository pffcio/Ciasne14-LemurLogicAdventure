extends RichTextLabel

@export var target_color: Color = Color(0, 0, 0) # Target color (e.g., red)
@export var color_change_speed: float = 1.0 # Speed of color change

func _ready() -> void:
	# Set initial color
	modulate = Color(1, 1, 1) # Start with white

func _process(delta: float) -> void:
	# Smoothly transition the color towards the target color
	modulate = modulate.lerp(target_color, color_change_speed * delta)
