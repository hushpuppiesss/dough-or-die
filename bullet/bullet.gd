extends CharacterBody2D

var speed = 3
var direction = Vector2.RIGHT
@onready var pop_sound = $pop

func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)


func _process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity)
	
	#if collision:
		#queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		# enemy disappears
		body.hit()
		# bullet disappears
		self.hit()
	else:
		# bullet disappears when hitting furniture or wall or whatever
		pop()
	
func hit():
	self.queue_free()

func pop():
	pop_sound.play()
	await get_tree().create_timer(0.30).timeout # waits for pop sound to finish playing
	self.queue_free()
