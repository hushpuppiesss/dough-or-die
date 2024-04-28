extends Node

var current_scene = SceneSwitcher.current_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	print(current_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
