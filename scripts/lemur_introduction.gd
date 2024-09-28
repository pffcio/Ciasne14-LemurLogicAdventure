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
func _ready() -> void:
	$HBoxContainer/Dialog.text = dialogCollection[dialogInt]
	
func _input(event):
	# Check if the event is a mouse button click and if it's the left mouse button (button index 1)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Call the function to handle the action when the left mouse button is clicked
		_on_left_button_click()

func _on_left_button_click():
	# Your action code here
	if(dialogInt < 4):
		dialogInt=dialogInt+1
		$HBoxContainer/Dialog.text=dialogCollection[dialogInt]
	else:
		print("Scena po tutorialu")
	# Add any custom action you want to trigger here
