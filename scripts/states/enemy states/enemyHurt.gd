extends State
class_name enemyHurt

@onready var healthbar = $healthBar

@export var enemy : CharacterBody2D
@export var move_speed := 125.0
@export var health := 100
var player : CharacterBody2D

func hurt():
	pass
	
func Enter():
	healthbar.init_health(health)

func Physics_Update(delta: float):
	pass
	
