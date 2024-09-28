extends Area2D

var speed = 200

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D):
	print("HIT")
	if is_instance_of(body, Enemy):
		body.hit(10)
		queue_free()
