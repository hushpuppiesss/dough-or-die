extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var progress_bar = $"progress bar"

# spits out dough
@export_category("Doughnuts")
@export var boston_kreme: PackedScene
@export var strawberry_sprinkle: PackedScene
@export var glazed: PackedScene
@export var blueberry_filled: PackedScene
@onready var doughnut : PackedScene

# icons
@onready var cooked_dough_icon = $"cooked dough icon"
@onready var cooked_dough_anim = $"cooked dough icon/AnimationPlayer"
@onready var topping_selection = $"topping selection"
@onready var topping_selection_anim = $"topping selection/AnimationPlayer"

# keeps track of the ingredients inside
@onready var ingredients_in = []

# if its full or empty
@onready var loaded = false

# if its done mixing
@onready var mixed = false

@onready var player = InteractionManager.player

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_fry")
	cooked_dough_anim.play("float")
	topping_selection_anim.play("float")
	progress_bar.hide()
	
func _fry():
	if loaded == false:
		# check if player has an ingredient to put in
		if CookingManager.carrying:
			if CookingManager.item_in_hand.is_in_group("dough cooked") && !ingredients_in.has("dough cooked"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				cooked_dough_icon.visible = false
				
				#print(ingredients_in)
			if CookingManager.item_in_hand.is_in_group("sugar") && !ingredients_in.has("chocolate") && !ingredients_in.has("strawberry") && !ingredients_in.has("blueberry"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				topping_selection.visible = false
			
			if CookingManager.item_in_hand.is_in_group("chocolate") && !ingredients_in.has("sugar") && !ingredients_in.has("strawberry") && !ingredients_in.has("blueberry"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				topping_selection.visible = false
			
			if CookingManager.item_in_hand.is_in_group("strawberry") && !ingredients_in.has("chocolate") && !ingredients_in.has("sugar") && !ingredients_in.has("blueberry"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				topping_selection.visible = false
			
			if CookingManager.item_in_hand.is_in_group("blueberry") && !ingredients_in.has("chocolate") && !ingredients_in.has("strawberry") && !ingredients_in.has("sugar"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				topping_selection.visible = false
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# checking ingredients
	if ingredients_in.has("dough cooked"):
		if ingredients_in.has("chocolate"):
			doughnut = boston_kreme
			loaded = true
			progress_bar.show()
			$Timer.start()
			ingredients_in.clear()
		if ingredients_in.has("strawberry"):
			doughnut = strawberry_sprinkle
			loaded = true
			progress_bar.show()
			$Timer.start()
			ingredients_in.clear()
		if ingredients_in.has("sugar"):
			doughnut = glazed
			loaded = true
			progress_bar.show()
			$Timer.start()
			ingredients_in.clear()
		if ingredients_in.has("blueberry"):
			doughnut = blueberry_filled
			loaded = true
			progress_bar.show()
			$Timer.start()
			ingredients_in.clear()
			
	progress_bar.value = $Timer.time_left
	
func _on_timer_timeout():
	mixed = true
	loaded = false
	
	cooked_dough_icon.visible = true
	topping_selection.visible = true
	progress_bar.hide()
	
	var newInstance = doughnut.instantiate()
	add_child(newInstance)
	CookingManager.ingredient_spawned = true
	newInstance.position.x += 100
	newInstance.position.y += 8
