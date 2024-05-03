extends CharacterBody2D

@onready var interaction_area = $InteractionArea
@onready var anim = $AnimatedSprite2D

func _ready():
	interaction_area.interact = Callable(self, "_feed")
	anim.play("default")

func updateAnim():
	pass
	
func _feed():
	pass

func _correct_donut():
	pass

func _incorrect_donut():
	pass
