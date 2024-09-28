extends Node

signal task_complited(succedded);

var max_correct_answers_true_false = 3
var correct_answers_true_false = 0
var max_correct_answers_connectors = 3
var correct_answers_connectors = 0

func _ready():
	task_complited.connect(_on_task_completed)
	
func _on_task_completed(succedded):
	print("YUPIIII", succedded)

