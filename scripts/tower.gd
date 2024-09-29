extends Node2D

class_name Tower

@export var animated_sprite: AnimatedSprite2D
@export var do_rotation: bool = false
@export var ammo_point: Marker2D
@export var ammo_timeout_in_seconds: float
@export var is_shooting = false
var enemy_in_range_list: Array[Enemy] = []
var current_enemy: Enemy = null
@onready var sprite = $Sprite2D

@onready var ammo = preload("res://scenes/towers/ammo.tscn")
@onready var d_down_menu = $OptionButton
@export var selected_ans = ""
@export var bullet_dmg = 10

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var opt_id = 1
	for i in range(GameController.quests_for_tower_def.size()):
		for j in range(1, GameController.quests_for_tower_def[i].size() - 1):
			print(i)
			print(j)
			d_down_menu.add_item(GameController.quests_for_tower_def[i][j], opt_id)
			opt_id += 1
	add_child(animated_sprite)
	timer.wait_time = ammo_timeout_in_seconds
	timer.autostart = false
	timer.timeout.connect(_attack)
	add_child(timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_enemy == null && len(enemy_in_range_list) == 0:
		return
	
	elif current_enemy != null && len(enemy_in_range_list) == 0:
		animated_sprite.stop()
		timer.stop()
		current_enemy = null
		
	elif current_enemy != null:
		if do_rotation:
			animated_sprite.look_at(current_enemy.global_position)
			animated_sprite.rotation_degrees -= 90
		if timer.is_stopped():
			timer.start()
		
	else:
		_assign_curr_enemy()
		animated_sprite.play()
	


func _on_range_area_entered(area: Node2D):
	if is_instance_of(area, Enemy):
		enemy_in_range_list.append(area)


func _on_range_area_exited(area: Node2D):
	if area in enemy_in_range_list:
		enemy_in_range_list.erase(area)


func _on_enemy_died(enemy: Enemy):
	if enemy in enemy_in_range_list:
		enemy_in_range_list.erase(enemy)


func _assign_curr_enemy():
	current_enemy = enemy_in_range_list[0]


func _attack():	
	if current_enemy == null:
		animated_sprite.stop()
		timer.stop()
		is_shooting = false
		return
	
	if "Crossbow" in get_parent().name:
		AudioPlayer.play_pitch_sfx("crossbow_attack")
	elif "Basic" in get_parent().name:
		AudioPlayer.play_pitch_sfx("basic_attack")
	elif "Tesla" in get_parent().name:
		AudioPlayer.play_pitch_sfx("tesla_attack")

	var ammo_instance = ammo.instantiate()
	ammo.dmg = bullet_dmg
	ammo_point.look_at(current_enemy.global_position)
	ammo_point.add_child(ammo_instance)
	is_shooting = true
	
	


func _on_option_button_item_selected(index: int) -> void:
	selected_ans = d_down_menu.get_item_text(index)
