extends Control

var dialog = "Świetnie Ci poszło! Teraz spróbuj dopasować odpowiednie słowo, aby cała wypowiedź była prawdziwa.
Pamiętaj, że:
Koniunkcja (czyli \"i\") – To takie zdanie, w którym oba zdania muszą być prawdziwe, żeby całość była prawdą.

Alternatywa (czyli \"lub\") – Tutaj wystarczy, że jedno ze zdań będzie prawdziwe, żeby całość była prawdą.

Negacja (czyli \"nie\") – To zdanie, które mówi, że coś nie jest prawdą."

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer 

func _ready() -> void:
	%Dialog.text=dialog
	audio_player.play()
	audio_player.finished.connect(_on_audio_finished)
	
func _input(event):
	# Check if the event is a mouse button click and if it's the left mouse button (button index 1)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Call the function to handle the action when the left mouse button is clicked
		_on_left_button_click()

func _on_left_button_click():
	proceed_with_tutorial()

func proceed_with_tutorial():
		print("Scena po tutorialu")
	# Add any custom action you want to trigger here


func _on_audio_finished():
	await get_tree().create_timer(0.5).timeout
	proceed_with_tutorial()
