extends CharacterBody2D

# enemy stats
var speed = 100 # note that because we're dividing by speed, the lower the speed the faster it is in actuality
var health = 100

# enemy behavior
var player_chase = false
var player = null

var player_inattack_range = false

# animations
@onready var animations = $AnimatedSprite2D
@onready var previousDirection: String = "Down"

# signal that this is the enemy to make the attacks work
func enemy():
	pass
	
func _physics_process(delta):
	dealDamage()
	
	if player_chase:
		# moves towards the player
		position += (player.position - position)/speed
		
		# updating the animations
		var direction = "Down"
		if (player.position.y - position.y) < 0: direction = "Up"
		if (player.position.x - position.x) < 0: direction = "Left"
		if (player.position.x - position.x) > 0: direction = "Right"
		
		
		animations.play("walk" + direction)
		previousDirection = direction
	else: 
		animations.play("idle" + previousDirection)

# --- chasing player
func _on_detection_area_body_entered(body):
	# the player is the body that will enter the detection zone
	player = body
	# chase the player if the body has entered
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	# stop chasing player after player is outside of zone
	player_chase = false
	
# --- attacking player
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_range = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_range = false
		
func dealDamage():
	if player_inattack_range and global.player_current_attack:
		health -= 20
		print("slime health = ", health)
		if health <= 0:
			self.queue_free()
