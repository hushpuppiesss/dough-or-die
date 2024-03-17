extends CharacterBody2D

@export var speed: int = 150
@onready var animations = $AnimationPlayer
@onready var previousDirection: String = "Down"

# --- input handler
func handleInput():
	# getting movement direction from input
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# velocity, direction * speed
	velocity = moveDirection * speed

# -- updating player animation
func updateAnimation():
	var direction = "Down"
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Up"
	
	# idle animations
	if velocity.length() == 0:
		animations.play("idle" + previousDirection)
	# walk animations
	else:
		animations.play("walk" + direction)
		previousDirection = direction

# --- game loop that updates the state of the game
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
