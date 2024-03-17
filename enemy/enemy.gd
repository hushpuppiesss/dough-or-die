extends CharacterBody2D

# strawberry enemy
var speed = 100 # note that because we're dividing by speed, the lower the speed the faster it is in actuality
var player_chase = false
var player = null

@onready var animations = $AnimatedSprite2D
@onready var previousDirection: String = "Down"

func _physics_process(delta):
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

func _on_detection_area_body_entered(body):
	# the player is the body that will enter the detection zone
	player = body
	# chase the player if the body has entered
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	# stop chasing player after player is outside of zone
	player_chase = false
