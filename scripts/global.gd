extends Node

signal task_complited(succedded);

var max_correct_answers_true_false = 3
var correct_answers_true_false = 0
var max_correct_answers_connectors = 3
var correct_answers_connectors = 0

# Music related stuff
signal is_main_menu(value: bool)
signal is_paused(value: bool)
signal is_wave(value: bool)
signal is_prepare(value: bool)
var is_prepare_val = false
var is_wave_val = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	task_complited.connect(_on_task_completed)
	
func _on_task_completed(succedded):
	print("YUPIIII", succedded)
