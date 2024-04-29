extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D

@export var milk : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_get_milk")

func _get_milk():
	
	var newInstance = milk.instantiate()
	add_child(newInstance)
	#sprite.frame = 1 if sprite.frame == 0 else 0
	
	#for n in range(6):
		#sprite.frame = n

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
