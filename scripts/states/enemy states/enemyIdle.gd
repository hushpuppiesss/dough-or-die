extends State
class_name EnemyIdle

# referencing the enemy
@export var enemy: CharacterBody2D
@export var move_speed := 20.0

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	
# when we enter the state, the following executes
func Enter():
	randomize_wander()
	
func Update(delta: float):
	if wander_time > 0:
		# tick down by delta
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
