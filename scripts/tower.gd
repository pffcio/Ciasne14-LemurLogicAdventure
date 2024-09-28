extends Node2D

class_name Tower

@export var animated_sprite: AnimatedSprite2D
@export var do_rotation: bool = false
@export var ammo_point: Marker2D
@export var ammo_timeout_in_seconds: float
var enemy_in_range_list: Array[Enemy] = []
var current_enemy: Enemy = null
@onready var sprite = $Sprite2D

@onready var ammo = preload("res://scenes/towers/ammo.tscn")

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
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
			animated_sprite.rotation_degrees += 90
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
		return
	
	var ammo_instance = ammo.instantiate()
	ammo_point.look_at(current_enemy.global_position)
	ammo_point.add_child(ammo_instance)
	
	
