extends CharacterBody2D
class_name Enemy

@onready var anim = $AnimatedSprite2D
@onready var healthbar = $healthBar


func _ready():
	pass

func _physics_process(delta):
	move_and_slide()
	
	# animations
	if velocity.length() > 0:
		if velocity.x > 0:
			anim.play("walkRight")
		else:
			anim.play("walkLeft")

func hit():
	self.queue_free()


func _on_hitbox_body_entered(body):
	if body.name == "player":
		body.hurt()


