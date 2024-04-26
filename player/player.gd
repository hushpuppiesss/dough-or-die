extends CharacterBody2D
class_name player

# player stats
@export var health = 100
@export var speed = 150
var alive = true

# animations
@onready var animations = $AnimatedSprite2D
@onready var previousDirection: String = "Down"

# enemy in range to attack
var hurt_range = false
# cooldown to get hurt
var hurt_cooldown = true

# combat system
var attack_ip = false # attack in progress

# --- GAME LOOP that updates the state of the game
func _physics_process(delta):
	
	# get the input
	handleInput()
	
	# move
	move_and_slide()
	
	# updating the animations
	updateAnimation()
	
	# if player gets hurt
	hurt()
	
	if health <= 0:
		alive = false
	
# --- input handler
func handleInput():
	# getting movement direction from input
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# velocity, direction * speed
	velocity = moveDirection * speed

# -- updating player animation
func updateAnimation():
	var direction = "Down"
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Up"
	
	# idle animations
	if velocity.length() == 0:
		if Cooking.carrying == true:
			animations.play("carryIdle" + previousDirection)
		# if hurt
		elif hurt_range and hurt_cooldown:
			animations.play("hurt" + previousDirection)
		else:
			animations.play("idle" + previousDirection)

	# walk animations
	else:
		animations.play("walk" + direction)
		
		if Cooking.carrying == true:
			animations.play("carryWalk" + direction)
			
		previousDirection = direction
	("hurt" + direction)
		

		
# -- getting hurt
func hurt():
	if hurt_range and hurt_cooldown:
		print("get rekt")
		health -= 10
		hurt_cooldown = false
		$"hurt cooldown".start()
		print(health)

# enemy close enough to hurt you
func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy"):
		hurt_range = true

# enemy is not close enough to hurt you
func _on_hurtbox_body_exited(body):
	if body.is_in_group("Enemy"):
		hurt_range = false
		
# cooldown for enemy hurting the player
func _on_hurt_cooldown_timeout():
	hurt_cooldown = true
