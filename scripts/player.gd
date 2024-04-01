extends CharacterBody2D
class_name player

# player stats
@export var health = 150
@export var playerAttack = 15
@export var speed = 150
var player_alive = true

# animations
@onready var animations = $AnimatedSprite2D
@onready var previousDirection: String = "Down"

# enemy in range to attack
#var enemy_inattack_range = false
## cooldown to attack
#var enemy_attack_cooldown = true

# combat system
var attack_ip = false # attack in progress

# --- GAME LOOP that updates the state of the game
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	
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
		if attack_ip == false:
			animations.play("idle" + previousDirection)
	# walk animations
	else:
		animations.play("walk" + direction)
		previousDirection = direction

func die():
	if health <= 0:
		print("you died")
		
## --- body enters hitbox
#func _on_player_hitbox_body_entered(body):
	#if body.has_method("enemy"):
		#enemy_inattack_range = true
#
## --- body leaves hitbox
#func _on_player_hitbox_body_exited(body):
	#if body.has_method("enemy"):
		#enemy_inattack_range = false
#
## --- if enemy is in range to attack
#func enemy_attack():
	#if enemy_inattack_range and enemy_attack_cooldown == true:
		#health -= 20
		#enemy_attack_cooldown = false
		#$damageCooldown.start()
		#print(health)
#
#func _on_attack_cooldown_timeout():
	#enemy_attack_cooldown = true
	#
## --- attack
#func attack():
	#var direction = previousDirection
	#
	#if Input.is_action_just_pressed("attack"):
		#global.player_current_attack = true
		#attack_ip = true
		#
		## animation
		#animations.play("attack" + direction)
		#$attackTimer.start()
#
## --- timer for player attack
#func _on_attack_timer_timeout():
	#$attackTimer.stop()
	#global.player_current_attack = false
	#attack_ip = false
