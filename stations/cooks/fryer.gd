extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var progress_bar = $"progress bar"

# spits out dough
@export var dough_cooked : PackedScene

# icons
@onready var raw_dough_icon = $"raw dough icon"
@onready var raw_dough_anim = $"raw dough icon/AnimationPlayer"


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
	raw_dough_anim.play("float")
	progress_bar.hide()
	
func _fry():
	if loaded == false:
		# check if player has an ingredient to put in
		if CookingManager.carrying:
			if CookingManager.item_in_hand.is_in_group("dough raw") && !ingredients_in.has("dough raw"):
				# adds ingredient to array
				ingredients_in.append(CookingManager.item_in_hand.name)
				CookingManager._put_down()
				CookingManager.item_in_hand.queue_free()
				raw_dough_icon.visible = false
				
				#print(ingredients_in)
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# checking ingredients
	if ingredients_in.has("dough raw"):
		loaded = true
		progress_bar.show()
		$Timer.start()
		ingredients_in.clear()
		
	progress_bar.value = $Timer.time_left
	
func _on_timer_timeout():
	mixed = true
	loaded = false
	
	raw_dough_icon.visible = true
	progress_bar.hide()
	
	var newInstance = dough_cooked.instantiate()
	add_child(newInstance)
	newInstance.position.x += 32
	newInstance.position.y += 48
