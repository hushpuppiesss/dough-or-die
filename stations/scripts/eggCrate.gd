extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D

@export var egg : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_get_egg")

func _get_egg():
	
	var newInstance = egg.instantiate()
	add_child(newInstance)
	#newInstance.position.y += 12

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
