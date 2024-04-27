extends CharacterBody2D
class_name Enemy

@onready var anim = $AnimatedSprite2D
@onready var squeak_sound = $squeak_sound
@onready var death_sound = $"death sound"
@onready var hitflash = $hitflash

# statistics
@export var move_speed := 125.0
@export var wander_speed := 25
@onready var health := 30
@onready var alive = true

# behavioral variables
var move_direction : Vector2
var knockback = Vector2.ZERO
var wander_time : float
var state_wander = true
var state_player_chase = false
var player = null

func _ready():
	# randomizes wander behavior  as soon as it enters
	randomize_wander()

func _physics_process(delta):
	# for knockback
	knockback = knockback.move_toward(Vector2.ZERO, 100 * delta)
	# if wandering time
	if alive:
		if state_wander:
			velocity = move_direction * wander_speed
			
			# animations
			if velocity.x > 0:
				anim.play("walkRight")
			else:
				anim.play("walkLeft")
		# if player is within rnage to chase
		elif state_player_chase:
			# move towards player
			position += (player.position - position)/move_speed
			
			# animations
			if (player.position.x - position.x) > 0:
				anim.play("walkRight")
			else:
				anim.play("walkLeft")
		# idling
		else:
			anim.play("idleDown")
		move_and_slide()
	else:
		anim.play("idleDown")

func _process(delta):
	# ticking down on wander time
	if wander_time > 0:
		wander_time -= delta
	# if wander time is over, then reset timer and randomize wander behavior again
	else:
		randomize_wander()



# when enemy gets hit by a bullet
func hit():
	hitflash.play("hit_flash")
	
	if health > 0:
		# death sound
		squeak_sound.play()
		# enemy gets knocked back
		knockback = Vector2.RIGHT * 60
		# lessening teh health
		health -= 10
	if health <= 0:
		alive = false
		death_sound.play()
		await get_tree().create_timer(1.0).timeout # waits for death sound to finish playing	
		# dies
		self.queue_free()
	

# when body enters detection area
func _on_detectionarea_body_entered(body):
	player = body
	state_player_chase = true
	state_wander = false

# when body leaves detection area
func _on_detectionarea_body_exited(body):
	player = null
	state_player_chase = false
	state_wander = true

# for wandering behavior
func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
