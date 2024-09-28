extends CharacterBody2D
class_name Enemy

@export var health = 10

func hit(demage: int):
	health -= demage
	if health <= 0:
		queue_free()
