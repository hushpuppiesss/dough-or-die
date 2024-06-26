extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D

@export var milk : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_get_milk")

func _get_milk():
	
	if CookingManager.ingredient_spawned == false:
		var newInstance = milk.instantiate()
		add_child(newInstance)
		newInstance.position.y += 16
		CookingManager.ingredient_spawned = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
