extends Node

signal task_complited(succedded);

func _ready():
	task_complited.connect(_on_task_completed)
	
func _on_task_completed(succedded):
	print("YUPIIII", succedded)
