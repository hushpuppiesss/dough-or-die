extends CharacterBody2D

# player stats
var health = 100
var player_alive = true
@export var speed: int = 150

# animations
@onready var animations = $AnimationPlayer
@onready var previousDirection: String = "Down"

# enemy in range to attack
var enemy_inattack_range = false
# cooldown to attack
var enemy_attack_cooldown = true

# combat system
var attack_ip = false # attack in progress

# --- GAME LOOP that updates the state of the game
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	
	enemy_attack()
	if health <= 0:
		player_alive = false # add end screen here
		health = 0
		print("game over")
	
# --- player function
func player():
	pass
	
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
		animations.play("idle" + previousDirection)
	# walk animations
	else:
		animations.play("walk" + direction)
		previousDirection = direction

# --- body enters hitbox
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

# --- body leaves hitbox
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health -= 20
		enemy_attack_cooldown = false
		$attackCooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
