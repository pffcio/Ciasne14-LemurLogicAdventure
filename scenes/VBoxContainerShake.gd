extends VBoxContainer
# Duration of the shake in seconds
var shake_duration = 0

# Intensity of the shake (how much it moves)
var shake_intensity = 0

# Time elapsed since the shake started
var shake_time = 0

# Original position of the node
var original_position: Vector2

# Ready function
func _ready():
	original_position = position

# Start shaking function
func start_shake(duration: float, intensity: float):
	shake_duration = duration
	shake_intensity = intensity
	shake_time = 0

# Function called every frame to update the shake
func _process(delta: float):
	if shake_time < shake_duration:
		shake_time += delta
		position = original_position + Vector2(
			randf_range(-shake_intensity, shake_intensity),
 			randf_range(-shake_intensity, shake_intensity)
		)
	else:
		position = original_position
