extends Node2D

class_name Tower

var enemy_in_range_list = []
var current_enemy: Enemy = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_enemy == null && len(enemy_in_range_list) == 0:
		return
	
	elif current_enemy != null && len(enemy_in_range_list) == 0:
		current_enemy = null
		
	elif current_enemy != null:
		_attack()
		
	else:
		_assign_curr_enemy()
	


func _on_range_area_entered(area):
	if area.class is Enemy:
		enemy_in_range_list.append(area)


func _on_range_area_exited(area):
	if area in enemy_in_range_list:
		enemy_in_range_list.erase(area)


func _on_enemy_died(enemy: Enemy):
	if enemy in enemy_in_range_list:
		enemy_in_range_list.erase(enemy)


func _assign_curr_enemy():
	current_enemy = enemy_in_range_list[0]


func _attack():
	# TODO implement attack
	pass
