extends CharacterBody2D

var speed = 3
var direction = Vector2.RIGHT

func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)


func _process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity)
	
	#if collision:
		#queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.hit()
		self.hit()
		print("rah")
	else:
		poof()
	
func hit():
	self.queue_free()

func poof():
	self.queue_free()
