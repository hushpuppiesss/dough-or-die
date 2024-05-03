extends CharacterBody2D

@onready var interaction_area = $InteractionArea
@onready var anim = $AnimatedSprite2D

@onready var happy = $happy
@onready var sad = $sad


@export_category("Doughnuts")
@export var boston_kreme: PackedScene
@export var strawberry_sprinkle: PackedScene
@export var glazed: PackedScene
@export var blueberry_filled: PackedScene

# doughnut to be eaten
@onready var choice_donut : PackedScene
@onready var donut_checker

# collection of donuts to choose from
@onready var collection = [blueberry_filled, boston_kreme, glazed, strawberry_sprinkle]

# note on the animations...
@onready var thought_bubble = $thought_bubble
@onready var doughnut_icons = $thought_bubble/doughnuts
@onready var thought_bubble_anim = $AnimationPlayer
# doughnut order is blueberry filled, boston, glazed, strawberry

@onready var player = InteractionManager.player

func _ready():
	interaction_area.interact = Callable(self, "_feed")
	anim.play("default")
	thought_bubble_anim.play("float")
	
	# picks a random donut to eat
	_randomize_donut()
	
	# debug statements
	if choice_donut == boston_kreme:
		print("boston_kreme")
	if choice_donut == strawberry_sprinkle:
		print("strawberry_sprinkle")
	if choice_donut == glazed:
		print("glazed")
	if choice_donut == blueberry_filled:
		print("blueberry_filled")
		
	# donut checker
	if choice_donut == boston_kreme:
		donut_checker = "boston kreme"
	elif choice_donut == strawberry_sprinkle:
		donut_checker = "strawberry sprinkle"
	elif choice_donut == glazed:
		donut_checker = "glazed"
	elif choice_donut == blueberry_filled:
		donut_checker = "blueberry filled"
	
func _feed():
	# check if player has an ingredient to put in
		if CookingManager.carrying:
			# checks fi its a donut
			if CookingManager.item_in_hand.is_in_group("doughnut"):
			# check if its the correct donut
				if CookingManager.item_in_hand.is_in_group(donut_checker):
				# if correct donut, call the correct donut functin
					_correct_donut()
					# feeding timer
					$fed.start()
					
					thought_bubble.visible = false
					
					# resets settings
					CookingManager._put_down()
					CookingManager.item_in_hand.queue_free()
					CookingManager.ingredient_spawned = false
				else:
				# otherwise, incorrect donut
					_incorrect_donut()
					$fed.start()
					
					thought_bubble.visible = false
					
					CookingManager._put_down()
					CookingManager.item_in_hand.queue_free()
					CookingManager.ingredient_spawned = false
			# randomizing donut

func _correct_donut():
	ScoreManager.control.score_value += 50
	happy.play()
	anim.play("fed") # happy
	
	await get_tree().create_timer(5.0).timeout
	
	# return to normal animation
	anim.play("default")

func _incorrect_donut():
	ScoreManager.control.score_value -= 50
	sad.play()
	anim.play("unfed") # sad animation
	
	await get_tree().create_timer(5.0).timeout
	
	# return to normal animation
	anim.play("default")

func _randomize_donut():
	choice_donut = collection.pick_random()
	
	# donut checker
	if choice_donut == boston_kreme:
		donut_checker = "boston kreme"
	elif choice_donut == strawberry_sprinkle:
		donut_checker = "strawberry sprinkle"
	elif choice_donut == glazed:
		donut_checker = "glazed"
	elif choice_donut == blueberry_filled:
		donut_checker = "blueberry filled"
	
	# show animations again
	thought_bubble.visible = true
	
	if choice_donut == boston_kreme:
		doughnut_icons.set_frame(1)
	if choice_donut == strawberry_sprinkle:
		doughnut_icons.set_frame(3)
	if choice_donut == glazed:
		doughnut_icons.set_frame(2)
	if choice_donut == blueberry_filled:
		doughnut_icons.set_frame(0)

func _on_fed_timeout():
	# after being fed, go again by randomizign donut
	_randomize_donut()

func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("debug"):
		var test_donut = choice_donut.instantiate()
		add_child(test_donut)
		test_donut.position.y = 100
		
