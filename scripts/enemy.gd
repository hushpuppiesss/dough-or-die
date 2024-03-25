extends CharacterBody2D
class_name StrawberryEnemy

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	move_and_slide()
	
	# animations
	if velocity.length() > 0:
		if velocity.x > 0:
			anim.play("walkRight")
		else:
			anim.play("walkLeft")


#@onready var healthbar = $healthBar
#
## enemy stats
#@export var speed: int # note that because we're dividing by speed, 
						## the lower the speed the faster it is in actuality
#@export var health: int
#@export var enemyAttack = 20
#
## enemy behavior
#var player_chase = false
#var player = null
#
#var player_inattack_range = false
#var can_take_damage = true
#var knockback = false
#
## animations
#@onready var animations = $AnimatedSprite2D
#@onready var previousDirection: String = "Down"
#
## signal that this is the enemy to make the attacks work
#func enemy():
	#pass
	#
#func _ready():
	#speed = 100
	#health = 100
	#healthbar.init_health(health)
	#
#func _physics_process(delta):
	#dealDamage()
	#
	#if player_chase:
		## moves towards the player
		#position += (player.position - position)/speed
		#
		## updating the animations
		#var direction = "Down"
		#if (player.position.y - position.y) < 0: direction = "Up"
		#if (player.position.x - position.x) < 0: direction = "Left"
		#if (player.position.x - position.x) > 0: direction = "Right"
		#
		#
		#animations.play("walk" + direction)
		#previousDirection = direction
	#else: 
		#animations.play("idle" + previousDirection)
#
## --- chasing player
#func _on_detection_area_body_entered(body):
	## the player is the body that will enter the detection zone
	#player = body
	## chase the player if the body has entered
	#player_chase = true
#
#
#func _on_detection_area_body_exited(body):
	#player = null
	## stop chasing player after player is outside of zone
	#player_chase = false
	#
## --- attacking player
#func _on_enemy_hitbox_body_entered(body):
	#if body.has_method("player"):
		#player_inattack_range = true
#
#func _on_enemy_hitbox_body_exited(body):
	#if body.has_method("player"):
		#player_inattack_range = false
		#
#func dealDamage():
	#if player_inattack_range and global.player_current_attack:
		#if can_take_damage == true:
			#health -= 20
			## starts timer for cooldown
			#$damageCooldown.start()
			## cannot take damage during this cooldown
			#can_take_damage = false
			#
			#
#
#
#func _on_damage_cooldown_timeout():
	#can_take_damage = true
	#
#func _set_health(value):
	#value = health
	#
	#if health <= 0:
			#self.queue_free()
	#healthbar.health = health
	#
#
