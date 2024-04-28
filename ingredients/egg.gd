extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var player = InteractionManager.player
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_pick_up")

func _pick_up():
	if CookingManager.can_pick_up:
		CookingManager.carrying = true
		CookingManager.can_pick_up = false
		reparent(player)
		
# if dropped
func _input(event):
	if event.is_action_pressed("drop"):
		reparent(InteractionManager.world)
		self.position = position
		CookingManager.can_pick_up = true
		CookingManager.carrying = false
		collision_shape_2d.set_deferred("disabled", true)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
