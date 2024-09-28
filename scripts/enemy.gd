extends CharacterBody2D
class_name Enemy

@export var health = 20

func hit(demage: int):
	health -= demage
	if health <= 0:
		queue_free()

func path_finished():
	get_parent().get_parent().get_parent().enemy_finished.emit(self)
