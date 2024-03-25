extends State
class_name EnemyChase

@export var enemy : CharacterBody2D
@export var move_speed := 100.0
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 50:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	
	# if player moves too far away, go to idle state
	if direction.length() > 100:
		Transitioned.emit(self, "idle")
