extends Control


@onready var pause_panel = $CanvasLayer/Pause_menu
@onready var pause_button = $CanvasLayer/Normal_UI/Pause
@onready var play_button = $CanvasLayer/Normal_UI/Play
@onready var tower_panel = $CanvasLayer/Normal_UI/Tower_panel
@onready var main_menu = preload("res://scenes/main_menu.tscn")
@onready var puzzle_texture = $CanvasLayer/Normal_UI/Panel/Puzzle/TextureRect
@onready var puzzle_text = $CanvasLayer/Normal_UI/Panel/Puzzle/TextEdit

signal next_level

var last_puzzle: int = -1
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameController.random_question.connect(_on_random_question)


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


func _on_random_question():
	pass
	
func set_play_disabled(disabled: bool):
	play_button.disabled = disabled

func show_next_level():
	$CanvasLayer/Next_level.show()

func _on_next_level_pressed():
	next_level.emit()
