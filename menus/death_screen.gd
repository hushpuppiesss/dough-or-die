extends Control
@onready var button_resume = $PanelContainer/MarginContainer/VBoxContainer/resume
@onready var button_quit = $PanelContainer/MarginContainer/VBoxContainer/quit
@onready var button_restart = $PanelContainer/MarginContainer/VBoxContainer/restart
@onready var player = InteractionManager.player

func _ready():
	$AnimationPlayer.play("RESET")
	button_quit.disabled = true
	button_restart.disabled = true

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
	get_tree().reload_current_scene()
	
	CookingManager.can_pick_up = true
	CookingManager.carrying = false
	CookingManager.ingredient_spawned = false

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	if player.alive == false:
		pause()
