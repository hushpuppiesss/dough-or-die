extends Node

@onready var can_pick_up = true
@onready var carrying : bool
@onready var item_in_hand : CharacterBody2D

func _physics_process(delta):
	#print(item_in_hand)
	pass

func _picked_up():
	can_pick_up = false
	carrying = true
	item_in_hand.interaction_area.set_monitoring(false)

func _put_down():
	can_pick_up = true
	carrying = false
	item_in_hand.interaction_area.set_monitoring(true)
