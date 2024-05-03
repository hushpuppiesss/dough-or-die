extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var progress_bar = $"progress bar"

# spits out dough
@export var doughnut_raw : PackedScene

# icons
@onready var recipe_book_icon = $"recipe book icon"
@onready var recipe_book_anim = $"recipe book icon/AnimationPlayer"


# keeps track of the ingredients inside
@onready var ingredients_in = []


@onready var player = InteractionManager.player

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_read")
	recipe_book_anim.play("float")
	
func _read():
		# check if player has an ingredient to put in
		if CookingManager.carrying:
			if CookingManager.item_in_hand.is_in_group("dough raw") && !ingredients_in.has("dough raw"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				
				#print(ingredients_in)
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
