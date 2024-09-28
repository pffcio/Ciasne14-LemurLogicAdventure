extends Control

var dialog = "Gratulacje! Opanowanie podstaw logiki klasycznej to ogromne osiągnięcie, które pokazuje, że masz umiejętność myślenia w sposób jasny i uporządkowany. Teraz otwiera się przed Tobą fascynujący świat pełen kolejnych wyzwań i odkryć! Zachęcam Cię, abyś dalej zgłębiał tajniki logiki, bo to nie tylko ćwiczy umysł, ale także pomaga lepiej rozumieć otaczający nas świat. Kto wie, jakie ciekawe zagadki i pytania czekają na Ciebie w przyszłości! Trzymam kciuki za Twoje dalsze sukcesy!"

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
