extends CharacterBody2D
class_name Enemy

@onready var anim = $AnimatedSprite2D
@onready var healthbar = $healthBar
@onready var squeak_sound = $squeak_sound

# statistics
@export var move_speed := 125.0

var player_chase = false
var player = null

func _ready():
	pass

func _physics_process(delta):
	
	# if player is within rnage to chase
	if player_chase:
		# move towards player
		position += (player.position - position)/move_speed
		
		# animations
		if velocity.x > 0:
			anim.play("walkRight")
		else:
			anim.play("walkLeft")
	# idling
	else:
		anim.play("idleDown")
	
	
		

# when enemy gets hit by a bullet
func hit():
	# death sound
	squeak_sound.play()
	await get_tree().create_timer(0.35).timeout # waits for death sound to finish playing
	
	# dies
	self.queue_free()


# when body enters detection area
func _on_detectionarea_body_entered(body):
	player = body
	player_chase = true

# when body leaves detection area
func _on_detectionarea_body_exited(body):
	player = null
	player_chase = false
