extends PathFollow2D
	
var speed = 105

func _physics_process(delta):
	progress += speed * delta
	if progress_ratio > 0.9:
		queue_free()
