extends Control
@onready var button_resume = $PanelContainer/MarginContainer/VBoxContainer/resume
@onready var button_quit = $PanelContainer/MarginContainer/VBoxContainer/quit
@onready var button_restart = $PanelContainer/MarginContainer/VBoxContainer/restart

func _ready():
	$AnimationPlayer.play("RESET")
	button_resume.disabled = true
	button_quit.disabled = true
	button_restart.disabled = true
	

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	button_resume.disabled = true
	button_quit.disabled = true
	button_restart.disabled = true
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	button_resume.disabled = false
	button_quit.disabled = false
	button_restart.disabled = false
	
func testEsc():
	if Input.is_action_just_pressed("escape") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()


func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
