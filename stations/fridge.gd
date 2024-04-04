extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_open_fridge")

func _open_fridge():
	
	print("fridge is opened")
	#sprite.frame = 1 if sprite.frame == 0 else 0
	
	#for n in range(6):
		#sprite.frame = n

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
