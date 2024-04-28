extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_pick_up")

func _pick_up():
	
	CookingManager.carrying = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
