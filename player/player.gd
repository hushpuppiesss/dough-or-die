extends CharacterBody2D
class_name player

# player stats
@onready var health = 100
@export var speed = 150
@onready var alive = true

# animations
@onready var animations = $AnimatedSprite2D
@onready var previousDirection: String = "Down"
@onready var hitflash = $hitflash

# sfx
@onready var sfx_hurt = $hurt

#health
@onready var health_bar = $"health bar"

# enemy in range to attack
var hurt_range = false
# cooldown to get hurt
var hurt_cooldown = true

# combat system
var attack_ip = false # attack in progress

func _ready():
	# assigning itself to interactionmanager variable
	InteractionManager.player = self

	
# --- GAME LOOP that updates the state of the game
func _physics_process(delta):
	
	# get the input
	handleInput()
	
	# updating the animations
	updateAnimation()
	
	# if player gets hurt
	hurt()
	
	# updating player health
	update_health()
	
	# move
	move_and_slide()
	
	
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
	

	# if hurt
	if  hurt_range and hurt_cooldown:
		animations.play("hurt" + previousDirection)
	# idle animations
	elif velocity.length() == 0:
		if Cooking.carrying == true:
			animations.play("carryIdle" + previousDirection)
		else:
			animations.play("idle" + previousDirection)
	# walk animations
	else:
		if Cooking.carrying == true:
			animations.play("carryWalk" + direction)
		else:
			animations.play("walk" + direction)
		
		previousDirection = direction
	

		
# -- getting hurt
func hurt():
	if alive and hurt_range and hurt_cooldown:
		hitflash.play("hit_flash")
		sfx_hurt.play()
		knockback()
		health -= 10
		hurt_cooldown = false
		$"hurt cooldown".start()
		print(health)

# -- updating the health
func update_health():
	var healthbar = $"health bar"
	healthbar.value = health
	
	# do not show healthbar if health is full
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

	
# -- dying
func die():
	print("dead")

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

# regeneration
func _on_regen_timer_timeout():
	if health < 100:
		health += 10
		if health > 100:
			health = 100
	# player does not regen if player is dead lol
	if health <= 0:
		health = 0

# -- knockback
func knockback():
	var knockbackDirection = -velocity.normalized() * 1000
	velocity = knockbackDirection
	move_and_slide()
