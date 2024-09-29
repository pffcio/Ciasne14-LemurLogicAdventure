extends Area2D

var speed = 200
@export var dmg = 10

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D):
	if is_instance_of(body, Enemy):
		body.hit(dmg)
		queue_free()
