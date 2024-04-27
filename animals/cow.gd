extends CharacterBody2D
class_name cow

@onready var anim = $AnimatedSprite2D
@onready var sfx_moo = $moo

# statistics
@export var wander_speed := 15

# behavioral variables
var move_direction : Vector2
var wander_time : float
var state_wander = true
var state_dawdle = false


func _ready():
	# randomizes wander behavior  as soon as it enters
	randomize_wander()
	
func _physics_process(delta):
	
	move_and_slide()
	
	# if wandering time
	if state_wander:
		velocity = move_direction * wander_speed
		
		# animations
		if velocity.x > 0:
			anim.play("walk")
			anim.flip_h = false
		else:
			anim.play("walk")
			anim.flip_h = true
	# idling
	else:
		anim.play("idle")

func _process(delta):
	# ticking down on wander time
	if wander_time > 0:
		wander_time -= delta
	# if wander time is over, then reset timer and randomize wander behavior again
	else:
		randomize_wander()
	
# for wandering behavior
func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), 0).normalized()
	wander_time = randf_range(1,2)

	
	
