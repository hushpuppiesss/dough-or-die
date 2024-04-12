extends State
class_name enemyChase

@export var enemy : CharacterBody2D
@export var move_speed := 125.0
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	print(direction.length())
	
	if direction.length() > 50:
		enemy.velocity = direction.normalized() * move_speed
	
	# if player moves too far away, go to idle state
	if direction.length() > 150:
		Transitioned.emit(self, "Wander")
	

	
