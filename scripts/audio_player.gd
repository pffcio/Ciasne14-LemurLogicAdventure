extends Node

var sfx = {
	#"click": preload("res://Sounds/in_game/click.mp3"),
	#"click_release": preload("res://Sounds/in_game/click_release.mp3"),
	#"build_tower": preload("res://Sounds/in_game/build_tower.mp3"),
	#"hit": preload("res://Sounds/in_game/hit.mp3")
}

var timed_sfx = {

}

var movement_sfx = [

]

var music_sfx_names = [
	"menu_music",
	"level_bg"
]

var is_movement_running = false
var is_clicked_sound = false

#func _input(event):
	#if event is InputEventMouseButton && event.pressed && !is_clicked_sound:
		#is_clicked_sound = true
		#var asp = AudioStreamPlayer.new()
		##asp.stream = sfx["click"]
		#asp.name = "SFX"
		#asp = add_to_bus(asp, "clicked")
		#
		#add_child(asp)
		#asp.play()
		#
		#await asp.finished
		#asp.queue_free()
		#is_clicked_sound = false
	#
	##elif event is InputEventMouseButton && event.released && !is_clicked_sound


#func play_sfx(sfx_name: String):
	#if sfx.has(sfx_name):
		#var asp = AudioStreamPlayer.new()
		#asp.stream = sfx[sfx_name]
		#asp.name = "SFX"
		#asp = add_to_bus(asp, sfx_name)
		#
		#add_child(asp)
		#asp.play()
		#
		#await asp.finished
		#asp.queue_free()


func play_timed_sfx(sfx_name: String, signal_name):
	if timed_sfx.has(sfx_name):
		var asp = AudioStreamPlayer.new()
		asp.stream = timed_sfx[sfx_name]
		if sfx_name == "level_bg":
			asp.name = "level_bg"
		else:
			asp.name = "Timed_SFX"
		asp = add_to_bus(asp, sfx_name)
		
		add_child(asp)
		asp.play()
		
		await signal_name
		if asp != null:
			asp.queue_free()

func random_movement_sfx():
	if is_movement_running:
		return
	
	is_movement_running = true
	var asp = AudioStreamPlayer.new()
	asp.stream = movement_sfx[randi() % movement_sfx.size()]
	asp.name = "Movement_SFX"
	asp = add_to_bus(asp)
	
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()
	is_movement_running = false

func player_dead():
	for child in get_children():
		if child == null:
			continue
		if child.name == "Movement_SFX" || child.name == "SFX":
			await child.finished
		remove_child(child)
		child.queue_free()


func change_scene(boss_fight=false):
	print(len(get_children()))
	var sfx_to_del = []
	for child in get_children():
		if !boss_fight && child.name == "level_bg":
			continue
		sfx_to_del.append(child)
		
	for child in sfx_to_del:
		if child == null:
			continue
		if child.name == "Movement_SFX" || child.name == "SFX":
			await child.finished
		remove_child(child)
		child.queue_free()


func add_to_bus(asp, sfx_name="default"):
	if sfx_name in music_sfx_names:
		asp.bus = "Music"
	else:
		asp.bus = "SFX"
	
	return asp
