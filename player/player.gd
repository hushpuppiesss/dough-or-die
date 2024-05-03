extends CharacterBody2D
class_name player

# player stats
@onready var health = 100
@export var speed = 150
@onready var alive = true
@onready var is_dying = false

# animations
@onready var animations = $AnimatedSprite2D
@onready var previousDirection: String = "Down"
@onready var hitflash = $hitflash
@onready var direction : String

# sfx
@onready var sfx_hurt = $hurt

#health
@onready var health_bar = $"health bar"
@onready var death_timer = $"death timer"

@onready var camera = $camera

# enemy in range to attack
var hurt_range = false
# cooldown to get hurt
var hurt_cooldown = true

# combat system
var attack_ip = false # attack in progress

func _ready():
	# assigning itself to interactionmanager variable
	InteractionManager.player = self
	
	if InteractionManager.revived:
		await get_tree().create_timer(1.5).timeout
		Transition.animation.play("fadein")
		InteractionManager.revived = false
	
	# signal for when player dies
	death_timer.connect("timeout", Callable(self, "_on_deathtimer_timeout"))

	
# --- GAME LOOP that updates the state of the game
func _physics_process(delta):
	# check if player is dying and break out of process
	if is_dying:
		return
		
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
	if is_dying:
		return
		
	var direction = "Down"
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Up"
	
	# idle animations
	if velocity.length() == 0:
		if CookingManager.carrying == true:
			animations.play("carryIdle" + previousDirection)
			CookingManager.carrying_direction = previousDirection
		else:
			animations.play("idle" + previousDirection)
	# walk animations
	else:
		if CookingManager.carrying == true:
			animations.play("carryWalk" + direction)
			CookingManager.carrying_direction = direction
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
	if health <= 0:
		alive = false
		die()

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
	#if health <= 0:
		#alive = false
		#SceneSwitcher.goto_scene("res://menus/death_screen.tscn")
	if is_dying:
		return
	
	is_dying = true
	animations.play("die")
	await move_player_up_and_down()
	get_tree().change_scene_to_file("res://menus/death_screen.tscn")

# -- mario style death animation
func move_player_up_and_down():
	InteractionManager.world.bg_music.stop()
	await get_tree().create_timer(0.5).timeout
	
	$fail.play()
	
	var start_pos = position
	# going up by a 100
	var up_pos = start_pos + Vector2(0, -100)
	# disappears off the screen
	var down_pos = start_pos + Vector2(0, 720)
	
	while position.y > up_pos.y:
		position.y -= 5
		await get_tree().create_timer(0.01).timeout
	
	while position.y < down_pos.y:
		position.y += 5
		await get_tree().create_timer(0.01).timeout

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
	# player does not regen if player is dead lol
	if health <= 0:
		health = 0
	elif health < 100:
		health += 10
		if health > 100:
			health = 100

# -- knockback
func knockback():
	var knockbackDirection = -velocity.normalized() * 1000
	velocity = knockbackDirection
	move_and_slide()
