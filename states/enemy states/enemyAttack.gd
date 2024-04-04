extends State
class_name enemyAttack

@export var enemy : CharacterBody2D
@export var move_speed := 125.0
@export var attack := 20
var player : CharacterBody2D

var attackRange := false
var attackCooldown := false

@onready var cooldown = $attackCooldown

func attacks():
	if attackRange and attackCooldown:
		player.health -= attack
		attackCooldown = false
		cooldown.start()
		print(player.health)
		
func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	attacks()
	if attackRange == false:
		Transitioned.emit(self, "Chase")
	
func _on_enemy_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		attackRange = true

func _on_enemy_hitbox_body_exited(body):
	if body.is_in_group("Player"):
		attackRange = false

func _on_attack_cooldown_timeout():
	attackCooldown = true
	





