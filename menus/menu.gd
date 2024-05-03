extends Control

@onready var sfx_paper1 = $paper1


# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreManager.visible = false

# PRESSED
func _on_start_pressed():
	sfx_paper1.play()
	SceneSwitcher.goto_scene("res://world/main.tscn")

func _on_quit_pressed():
	get_tree().quit()
