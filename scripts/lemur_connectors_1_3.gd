extends Control


@export var next_scene: PackedScene
var question1: Array = ["res://Images/Cat500.png", "To jest kot ___ to jest pies", 1]
var question2: Array = ["res://Images/Cat500.png", "To ___ jest pies",  2]
var question3: Array = ["res://Images/House500.png", "Ten dom jest zielony ___ posiada czerwony dach", 0]
var	question4: Array = ["res://Images/House500.png", "Ten dom ma czerwony dach ___ ten dom nie ma okna", 1]
var question5: Array = ["res://Images/Dog500.png", "Ten pies ma obrożę ___ ma trzy łapy", 1]
var question6: Array = ["res://Images/Dog500.png", "To ___ jest lemur", 2]
var question7: Array = ["res://Images/Sun500.png", "Pada deszcz ___ świeci słońce", 1]
var question8: Array = ["res://Images/Sun500.png", "Słońce jest uśmiechnięte ___ smutne", 1]
var question9: Array = ["res://Images/TeddyBear500.png", "To ___ jest lemur", 2]
var question10: Array = ["res://Images/TeddyBear500.png", "Jest to pluszowy miś ___ ma kokardę",0]

var questions: Array = [question1,question2,question3,question4,question5,question6,question7,question8,question9,question10]
var question_selected

var answered = false

var dialogSoundCollection:Array=[]

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer 

func _ready():
	audio_player.finished.connect(_on_audio_finished)
	dialogSoundCollection.append(load("res://Sounds/Correct.mp3"))
	dialogSoundCollection.append(load("res://Sounds/Wrong.mp3"))
	question_selected = get_random_question()
	generate_question(question_selected)
	questions.remove_at(questions.find(question_selected))
	
func generate_question(question):
	%QuestionImage.texture = load(question[0])
	%Sentence.text = question[1]

func get_random_question():
	randomize()
	var random_index = randi() % questions.size()
	return questions[random_index]

func _on_a_1_pressed():
	check_for_correct_answer(0)

func _on_a_2_pressed():
	check_for_correct_answer(1)

func _on_a_3_pressed():
	check_for_correct_answer(2)



func check_for_correct_answer(answer_value):
	if(answer_value == question_selected[2]):
		print("Correct")
		GameController.correct_answers_connectors = GameController.correct_answers_connectors + 1
		audio_player.stream = dialogSoundCollection[0]  # Set the stream to the sound from the list
		audio_player.play()
		$Particle.emitting = true
		disable_all_buttons()
		answered = true
	else:
		print("Wrong")
		audio_player.stream = dialogSoundCollection[1]  # Set the stream to the sound from the list
		audio_player.play()
		$VBoxContainer.start_shake(0.3, 8)

func disable_all_buttons():
	$VBoxContainer/Answers/A1.disabled = true
	$VBoxContainer/Answers/A2.disabled = true
	$VBoxContainer/Answers/A3.disabled = true

func _on_audio_finished():
	if(answered && GameController.correct_answers_connectors<GameController.max_correct_answers_connectors):
		print(GameController.correct_answers_connectors)
		get_tree().reload_current_scene()
	if(GameController.correct_answers_connectors==GameController.max_correct_answers_connectors):
		print("Kolejna scena")
		get_tree().change_scene_to_packed(next_scene)
