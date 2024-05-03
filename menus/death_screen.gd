extends Control
@onready var button_resume = $PanelContainer/MarginContainer/VBoxContainer/resume
@onready var button_quit = $PanelContainer/MarginContainer/VBoxContainer/quit
@onready var button_restart = $PanelContainer/MarginContainer/VBoxContainer/restart
@onready var player = InteractionManager.player

func _ready():
	pause()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	button_quit.disabled = true
	button_restart.disabled = true
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	button_quit.disabled = false
	button_restart.disabled = false

func _on_restart_pressed():
	resume()
	
	CookingManager.can_pick_up = true
	CookingManager.carrying = false
	CookingManager.ingredient_spawned = false
	
	Transition.animation.play("fadeout")
	await get_tree().create_timer(1.5).timeout
	InteractionManager.revived = true
	get_tree().change_scene_to_file("res://world/main.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	pass
