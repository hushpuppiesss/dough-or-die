extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D

# spits out dough
@export var doughnut_raw : PackedScene

# icons
@onready var trash_icon = $"trash icon"
@onready var trash_icon_anim = $"trash icon/AnimationPlayer"


@onready var player = InteractionManager.player

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_trash")
	trash_icon_anim.play("float")
	
func _trash():
		# check if player has an ingredient to trash
		if CookingManager.carrying:
				# adds ingredient to array
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				
				#print(ingredients_in)
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
