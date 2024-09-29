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


var quests_for_tower_def = [
	["res://Images/Cat500.png", "To ___ i ___", "kot","nie pies","lemur", 2],
	["res://Images/Cat500.png", "To ___ lub ___", "jest czarne","jest w paski","lemur", 5],
	["res://Images/House500.png", "To ___ i ___", "kot","ma dach","dom", 5],
	["res://Images/House500.png", "To ___ lub ___", "jest zielone","pies","jest niebieskie", 2],
	["res://Images/Dog500.png", "To ___ i ___", "pies","nie pies","ma obrożę", 3],
	["res://Images/Dog500.png", "To ___ lub ___", "kot","lemur","pies", 4],
	["res://Images/Sun500.png", "To ___ i ___", "Słońce","kot","jest żółte", 3],
	["res://Images/Sun500.png", "To ___ lub ___", "Słońce","deszcz","pies", 2],
	["res://Images/TeddyBear500.png", "To ___ i ___", "miś","ma kokardkę","dom", 4],
	["res://Images/TeddyBear500.png", "To ___ lub ___", "pluszak","pies","dom", 4]
]

signal random_question
