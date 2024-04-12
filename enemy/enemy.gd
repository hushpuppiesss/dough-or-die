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

