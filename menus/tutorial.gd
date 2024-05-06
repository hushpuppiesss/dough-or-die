extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreManager.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$paper1.play()
	SceneSwitcher.goto_scene("res://menus/menu.tscn")
