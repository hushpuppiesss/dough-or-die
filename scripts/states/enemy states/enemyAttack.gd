extends State
class_name enemyAttack

@export var enemy : CharacterBody2D
@export var move_speed := 125.0
var player : CharacterBody2D


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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
