extends Node2D

class_name Tower

@export var animated_sprite: AnimatedSprite2D
var enemy_in_range_list: Array[Enemy] = []
var current_enemy: Enemy = null
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(animated_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_enemy == null && len(enemy_in_range_list) == 0:
		return
	
	elif current_enemy != null && len(enemy_in_range_list) == 0:
		animated_sprite.stop()
		current_enemy = null
		
	elif current_enemy != null:
		_attack(current_enemy)
		
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


func _attack(enemy: Enemy):
	animated_sprite.look_at(enemy.global_position)
