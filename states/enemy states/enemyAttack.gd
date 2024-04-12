extends State
class_name enemyAttack

@export var enemy : CharacterBody2D
@export var move_speed := 125.0
@export var attack := 20
var player : CharacterBody2D

var attackCooldown := false

@onready var cooldown = $attackCooldown

func attacks():
	if attackCooldown:
		player.health -= attack
		attackCooldown = false
		cooldown.start()
		print(player.health)
		
func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass

func _on_attack_cooldown_timeout():
	attackCooldown = true
	
