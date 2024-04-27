extends Node

var current_scene = null

func _ready():
	# fetching the current scene
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)
	
	# Using Object.call_deferred(), the second function will only run once all code from the current scene has completed. Thus, the current scene will not be removed while it is still being used (i.e. its code is still running).

func _deferred_goto_scene(path):
	
	# wait
	Transition.animation.play("fadeout")
	await get_tree().create_timer(1.5).timeout

	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)
	
	await get_tree().create_timer(1.5).timeout
	Transition.animation.play("fadein")

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
