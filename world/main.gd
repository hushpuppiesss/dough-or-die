extends Node2D

@onready var bg_music = $"bg music"


# Called when the node enters the scene tree for the first time.
func _ready():
	InteractionManager.world = self
	ScoreManager.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
