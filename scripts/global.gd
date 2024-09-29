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

var delete_bg_music_at_start = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	task_complited.connect(_on_task_completed)
	
func _on_task_completed(succedded):
	print("YUPIIII", succedded)

var quests_for_tower_def = [
	["To ___ i ___", "kot","nie pies", "and"],
	["To ___ lub ___", "jest czarne","jest w paski", "or"],
	["To ___ i ___", "kot","ma dach", "and"],
	["To ___ lub ___", "jest zielone","pies", "or"],
	["To ___ i ___", "pies","ma obrożę", "and"],
	["To ___ lub ___", "lemur","pies", "or"],
	["To ___ i ___", "Słońce","jest żółte", "and"],
	["To ___ lub ___", "Słońce","pies", "or"],
	["To ___ i ___", "miś","ma kokardkę", "and"],
	["To ___ lub ___", "pluszak","dom", "or"]
]




signal random_question
