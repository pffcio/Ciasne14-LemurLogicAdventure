extends Control


@onready var pause_panel = $CanvasLayer/Pause_menu
@onready var pause_button = $CanvasLayer/Normal_UI/Pause
@onready var tower_panel = $CanvasLayer/Normal_UI/Tower_panel
@onready var main_menu = preload("res://scenes/main_menu.tscn")


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pause_pressed():
	print("Wave ", GameController.is_wave_val)
	print("Prepare ", GameController.is_prepare_val)
	GameController.is_wave.emit(false)
	GameController.is_prepare.emit(false)
	GameController.is_paused.emit(true)
	get_tree().paused = true
	tower_panel.hide()
	pause_panel.show()


func _on_resume_pressed():
	GameController.is_paused.emit(false)
	GameController.is_wave.emit(GameController.is_wave_val)
	GameController.is_prepare.emit(GameController.is_prepare_val)
	get_tree().paused = false
	tower_panel.show()
	pause_panel.hide()


func _on_home_pressed():
	GameController.is_paused.emit(false)
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)


func _on_play_pressed():
	GameController.is_paused.emit(false)
	get_parent().start()
