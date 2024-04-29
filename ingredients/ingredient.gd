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
		CookingManager.item_in_hand = self
		CookingManager._picked_up()
		reparent(player)
		
# if dropped
func _input(event):
	if event.is_action_pressed("drop"):
		if CookingManager.carrying == true:
			reparent(InteractionManager.world)
			self.position = position
			CookingManager._put_down()
			CookingManager.item_in_hand = null
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
