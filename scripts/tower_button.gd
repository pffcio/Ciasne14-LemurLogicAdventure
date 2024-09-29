extends Panel

@export var tower_scene: PackedScene
@export var tower_type: String
var curr_tile


func _on_gui_input(event):
	var tempTower = tower_scene.instantiate()
	tempTower.set_z_index(10)
	var root_scene = get_tree().get_root()
	
	var mapPath: TileMapLayer = root_scene.get_child(root_scene.get_child_count() - 1).get_node("Path")
	var mapPathRect = mapPath.get_used_rect()
	var tile = mapPath.local_to_map(get_global_mouse_position())
	
	## TODO add for each level similar boolean
	var is_on_path = (mapPathRect.position.x <= tile.x && tile.x <= mapPathRect.size.x) && (mapPathRect.position.y <= tile.y && tile.y <= mapPathRect.position.y + mapPathRect.size.y - 1)
	
	if event is InputEventMouseButton && event.button_mask == 1:
		add_child(tempTower)
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
	elif event is InputEventMouseMotion && event.button_mask == 1:
		if get_child_count() > 2:
			get_child(2).global_position = event.global_position
			get_child(2).get_node("Area").show()
			if is_on_path:
				get_child(2).get_node("Area").modulate = Color(255, 0, 0, 0.2)
			else:
				get_child(2).get_node("Area").modulate = Color(255, 255, 255, 0.2)
	elif event is InputEventMouseButton && event.button_mask == 0:
		if get_child_count() > 2:
			get_child(2).queue_free()
			
		
		if event.global_position.x < 900:
			if !is_on_path:
				var path = root_scene.get_child(root_scene.get_child_count() - 1).get_node("Towers")
				
				path.add_child(tempTower)
				tempTower.global_position = event.global_position
				tempTower.get_node("Area").hide()
				AudioPlayer.play_sfx("build_tower")
	else:
		if get_child_count() > 2:
			get_child(2).queue_free()
