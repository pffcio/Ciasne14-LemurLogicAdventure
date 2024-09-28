extends Control

var firstDialog = "Cześć! Jestem Wojtek, lemur, który uwielbia skakać po drzewach, ale także po... logicznych myślach! Dzisiaj chciałbym Cię zaprosić na wyjątkową przygodę – razem poznamy coś, co nazywa się logiką klasyczną. Może brzmi to trochę poważnie, ale zapewniam, że to świetna zabawa dla Twojego bystrego umysłu! Gotowy? No to skaczemy!"
var secondDialog = "Co to jest logika?
Logika to jak takie zasady myślenia, które pomagają nam dowiedzieć się, co jest prawdą, a co nie. To trochę jak zabawa w detektywa, który odkrywa, jakie zdania są prawdziwe, a jakie nieprawdziwe."
var thirdDialog = "Jak działa logika klasyczna?
Wyobraź sobie, że masz dwa zdania:

Zdanie A: „Lemur Wojtek skacze po drzewach.”
Zdanie B: „Lemur Wojtek umie latać.”
Zasada jest taka, że w logice klasycznej zdania mogą być albo prawdziwe, albo nieprawdziwe. Na przykład:

Zdanie A jest prawdziwe, bo każdy wie, że lemury skaczą po drzewach.
Zdanie B nie jest prawdziwe, bo lemury nie potrafią latać, choć bardzo by chciały!"
var fourthDialog = "Zasady gry w logikę:
Koniunkcja (czyli \"i\") – To takie zdanie, w którym oba zdania muszą być prawdziwe, żeby całość była prawdą.

Przykład: „Wojtek skacze po drzewach i lubi banany.” – To prawda, bo Wojtek robi jedno i drugie!
Alternatywa (czyli \"lub\") – Tutaj wystarczy, że jedno ze zdań będzie prawdziwe, żeby całość była prawdą.

Przykład: „Wojtek skacze po drzewach lub umie latać.” – Ponieważ Wojtek skacze po drzewach (to prawda), zdanie jest prawdziwe, mimo że nie umie latać.
Negacja (czyli \"nie\") – To zdanie, które mówi, że coś nie jest prawdą.

Przykład: „Wojtek nie potrafi latać.” – To prawda, bo Wojtek nie potrafi latać."
var fifthDialog = "Zabawa z logiką
Pomyśl teraz o zdaniach, które są prawdziwe, nieprawdziwe, i próbuj łączyć je ze sobą! Na przykład:

„Dziś świeci słońce i pada deszcz” – Czy to może być prawda? Może, jeśli jest tęcza!
„Wojtek lubi kokosy lub skacze po księżycu” – Jak myślisz, które z tych zdań jest prawdziwe?
Logika to takie narzędzie, które pomaga nam lepiej rozumieć świat. Możesz je wykorzystać w każdej sytuacji – nawet wtedy, gdy trzeba zdecydować, czy zrobić lekcje przed czy po zabawie!

Gotowy na więcej przygód z logiką? Zostań ze mną, a razem odkryjemy jeszcze więcej tajemnic logicznych skoków!"

var dialogCollection:Array = [firstDialog,secondDialog,thirdDialog,fourthDialog,fifthDialog] 
var dialogInt = 0
var dialogSoundCollection:Array=[]

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer 

func _ready() -> void:
	# Load AudioStream resources into the array
	dialogSoundCollection.append(load("res://Sounds/firstDialog.mp3"))
	dialogSoundCollection.append(load("res://Sounds/secondDialog.mp3"))
	dialogSoundCollection.append(load("res://Sounds/thirdDialog.mp3"))
	dialogSoundCollection.append(load("res://Sounds/fourthDialog.mp3"))
	dialogSoundCollection.append(load("res://Sounds/fifthDialog.mp3"))
	show_introduction_text(dialogInt)
	play_sound(dialogInt)
	audio_player.finished.connect(_on_audio_finished)
	
func _input(event):
	# Check if the event is a mouse button click and if it's the left mouse button (button index 1)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Call the function to handle the action when the left mouse button is clicked
		_on_left_button_click()

func _on_left_button_click():
	proceed_with_tutorial()

func proceed_with_tutorial():
	if(dialogInt < dialogCollection.size()-1):
		dialogInt=dialogInt+1
		play_sound(dialogInt)
		show_introduction_text(dialogInt)
	else:
		print("Scena po tutorialu")
	# Add any custom action you want to trigger here

func show_introduction_text(index: int) ->void:
	%Dialog.text=dialogCollection[index]

func play_sound(index: int) -> void:
	audio_player.stream = dialogSoundCollection[index]  # Set the stream to the sound from the list
	audio_player.play()  # Play the sound

func _on_audio_finished():
	await get_tree().create_timer(0.5).timeout
	proceed_with_tutorial()
