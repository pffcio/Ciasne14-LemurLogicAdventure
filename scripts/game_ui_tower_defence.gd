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
	get_tree().paused = true
	tower_panel.hide()
	pause_panel.show()


func _on_resume_pressed():
	get_tree().paused = false
	tower_panel.show()
	pause_panel.hide()


func _on_home_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)


func _on_play_pressed():
	get_parent().start()
