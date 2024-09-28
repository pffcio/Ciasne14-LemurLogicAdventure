extends Control

var question1: Array = ["res://Images/Cat500.png", "Wskaż prawdziwe zdanie", "To jest kot","To jest pies","To jest lemur","To jest dom", 2]
var question2: Array = ["res://Images/Cat500.png", "Wskaż prawdziwe zdanie", "Ten kot jest czarny","Ten pies jest w paski","To jest lemur","Ten kot jest pomarańczowy w paski", 5]
var question3: Array = ["res://Images/House500.png", "Wskaż prawdziwe zdanie", "To jest kot","To jest pies","To jest lemur","To jest dom", 5]
var question4: Array = ["res://Images/House500.png", "Wskaż prawdziwe zdanie", "Ten dom jest zielony","To jest pies","Ten dom nie ma dachu","Ten dom jest niebieski", 2]
var question5: Array = ["res://Images/Dog500.png", "Wskaż nie-prawdziwe zdanie", "To jest pies","To nie jest pies","Ten pies ma obrożę","To nie jest dom", 3]
var question6: Array = ["res://Images/Dog500.png", "Wskaż prawdziwe zdanie", "To jest kot","To jest lemur","To jest pies","To jest dom", 4]
var question7: Array = ["res://Images/Sun500.png", "Wskaż nie-prawdziwe zdanie", "Słońce jest uśmiechnięte","To jest pies","To jest Słońce","To nie jest lemur", 3]
var question8: Array = ["res://Images/Sun500.png", "Wskaż prawdziwe zdanie", "To jest Słońce","Pada deszcz","To jest lemur","To jest dom", 3]
var question9: Array = ["res://Images/TeddyBear500.png", "Wskaż nie-prawdziwe zdanie", "To jest pluszowy miś","Miś ma kokardkę","To jest dom","To nie jest dom", 4]
var question10: Array = ["res://Images/TeddyBear500.png", "Wskaż prawdziwe zdanie", "To jest kot","To jest pies","To jest pluszowy miś","To jest dom", 4]

var questions: Array = [question1,question2,question3,question4,question5,question6,question7,question8,question9,question10]
var question_selected

var buttons:Array=[$VBoxContainer/Answers/A1,$VBoxContainer/Answers/A2,$VBoxContainer/Answers/A3,$VBoxContainer/Answers/A4]

var dialogSoundCollection:Array=[]
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer 

func _ready():
	dialogSoundCollection.append(load("res://Sounds/Correct.mp3"))
	dialogSoundCollection.append(load("res://Sounds/Wrong.mp3"))
	question_selected = get_random_question()
	generate_question(question_selected)
	
func generate_question(question):
	$VBoxContainer/Image.texture = load(question[0])
	%Task.text = question[1]
	$VBoxContainer/Answers/A1.text = question[2]
	$VBoxContainer/Answers/A2.text = question[3]
	$VBoxContainer/Answers/A3.text = question[4]
	$VBoxContainer/Answers/A4.text = question[5]

func get_random_question():
	randomize()
	var random_index = randi() % questions.size()
	return questions[random_index]

func _on_a_1_pressed():
	check_for_correct_answer($VBoxContainer/Answers/A1.text)

func _on_a_2_pressed():
	check_for_correct_answer($VBoxContainer/Answers/A2.text)

func _on_a_3_pressed():
	check_for_correct_answer($VBoxContainer/Answers/A3.text)

func _on_a_4_pressed():
	check_for_correct_answer($VBoxContainer/Answers/A4.text)

func check_for_correct_answer(answer_text):
	var q = question_selected[question_selected[6]]
	if(answer_text == question_selected[question_selected[6]]):
		print("Correct")
		audio_player.stream = dialogSoundCollection[0]  # Set the stream to the sound from the list
		audio_player.play()
		$Particle.emitting = true
		disable_all_buttons()
	else:
		print("Wrong")
		audio_player.stream = dialogSoundCollection[1]  # Set the stream to the sound from the list
		audio_player.play()
		$VBoxContainer.start_shake(0.3, 8)

func disable_all_buttons():
	$VBoxContainer/Answers/A1.disabled = true
	$VBoxContainer/Answers/A2.disabled = true
	$VBoxContainer/Answers/A3.disabled = true
	$VBoxContainer/Answers/A4.disabled = true
