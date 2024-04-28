extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

func _ready():
	pass

func _physics_process(delta):
	anim.play("default")
