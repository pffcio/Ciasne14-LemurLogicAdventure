extends Panel

@export var tower_scene: PackedScene
@export var tower_type: String
var curr_tile


func _on_gui_input(event):
	var tempTower = tower_scene.instantiate()
	
	if event is InputEventMouseButton && event.button_mask == 1:
		pass
	elif event is InputEventMouseMotion && event.button_mask == 1:
		pass
	elif event is InputEventMouseButton && event.button_mask == 0:
		pass
