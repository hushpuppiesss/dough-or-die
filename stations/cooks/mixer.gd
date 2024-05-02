extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var progress_bar = $"progress bar"

# spits out dough
@export var raw_dough : PackedScene

# icons
@onready var wheat_icon = $"wheat icon"
@onready var wheat_anim = $"wheat icon/AnimationPlayer"
@onready var milk_icon = $"milk icon"
@onready var milk_anim = $"milk icon/AnimationPlayer"
@onready var egg_icon = $"egg icon"
@onready var egg_anim = $"egg icon/AnimationPlayer"

# keeps track of the ingredients inside
@onready var ingredients_in = []

# if its full or empty
@onready var loaded = false

# if its done mixing
@onready var mixed = false

@onready var player = InteractionManager.player

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_mix")
	wheat_anim.play("float")
	milk_anim.play("float")
	egg_anim.play("float")
	progress_bar.hide()
	
func _mix():
	if loaded == false:
		# check if player has an ingredient to put in
		if CookingManager.carrying:
			if CookingManager.item_in_hand.is_in_group("flour") && !ingredients_in.has("flour"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				wheat_icon.visible = false
				
				#print(ingredients_in)
				
			if CookingManager.item_in_hand.is_in_group("egg") && !ingredients_in.has("egg"):
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				egg_icon.visible = false
				
				#print(ingredients_in)
				
			if CookingManager.item_in_hand.is_in_group("milk") && !ingredients_in.has("milk"):
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				CookingManager.ingredient_spawned = false
				milk_icon.visible = false
				
				#print(ingredients_in)
				
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# checking ingredients
	if ingredients_in.has("egg") && ingredients_in.has("milk") && ingredients_in.has("flour"):
		loaded = true
		progress_bar.show()
		$Timer.start()
		ingredients_in.clear()
		
	progress_bar.value = $Timer.time_left
	
func _on_timer_timeout():
	mixed = true
	loaded = false
	
	wheat_icon.visible = true
	milk_icon.visible = true
	egg_icon.visible = true
	progress_bar.hide()
	print("rah")
	
	var newInstance = raw_dough.instantiate()
	add_child(newInstance)
	CookingManager.ingredient_spawned = true
	newInstance.position.x += 32
	newInstance.position.y += 16
