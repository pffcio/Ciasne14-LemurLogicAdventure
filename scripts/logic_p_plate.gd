extends Node2D

class_name logic_plate
enum plate_types {
	AND,
	OR,
	IMPLIKACJA,
	ROWNOWAZNOSC,
	NEGACJA
}
var anim_names = [
	"and",
	"or",
	"implikacja",
	"rownowaznosc",
	"negacja"
]

var ans_1 = ""
var ans_2 = ""

@export var plate_type : plate_types
@onready var anim_sprite = $AnimatedSprite2D
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameController.quests_for_tower_def.shuffle()
	var selected : Array = GameController.quests_for_tower_def[0]
	ans_1 = selected[1]
	ans_2 = selected[2]
	print(ans_1)
	print(ans_2)
	if selected.back() == "and":
		plate_type = plate_types.AND
	elif selected.back() == "or":
		plate_type = plate_types.OR
	label.text = selected[0]
	anim_sprite.animation = anim_names[plate_type]	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_logic()


# logic handling
var left_tower : Tower = null 
var right_tower : Tower = null 

func _on_logic_left_body_entered(body: Node2D) -> void:
	if body is Tower and not is_instance_valid(left_tower):
		left_tower = body


func _on_logic_left_body_exited(body: Node2D) -> void:
	if is_instance_valid(left_tower):
		if left_tower == body:
			left_tower = null


func _on_logic_right_body_entered(body: Node2D) -> void:
	if body is Tower and not is_instance_valid(right_tower):
		right_tower = body


func _on_logic_right_body_exited(body: Node2D) -> void:
	if is_instance_valid(right_tower):
		if right_tower == body:
			right_tower = null


func handle_logic():
	if is_instance_valid(left_tower) and is_instance_valid(right_tower):
		match self.plate_type:
			plate_types.AND:
				if left_tower.selected_ans == ans_1 and right_tower.selected_ans == ans_2:
					left_tower.bullet_dmg = 20
					right_tower.bullet_dmg = 20
					print("AND OK")
			plate_types.OR:
				if left_tower.selected_ans == ans_1 or right_tower.selected_ans == ans_2:
					left_tower.bullet_dmg = 20
					right_tower.bullet_dmg = 20
					print("OR OK")
			plate_types.IMPLIKACJA:
				if not left_tower.selected_ans == ans_1 or right_tower.selected_ans == ans_2:
					left_tower.bullet_dmg = 20
					right_tower.bullet_dmg = 20
			plate_types.ROWNOWAZNOSC:
				if left_tower.selected_ans == ans_1 == right_tower.selected_ans == ans_2:
					left_tower.bullet_dmg = 20
					right_tower.bullet_dmg = 20
			_:
				left_tower.bullet_dmg = 10
				right_tower.bullet_dmg = 10
	
