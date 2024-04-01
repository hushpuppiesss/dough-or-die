extends Area2D
class_name InteractionArea

# default string that shown above object to indicate it can be interacted with
@export var action_name: String = "interact"

# callable is a type of variable that can hold a function
var interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self)

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
