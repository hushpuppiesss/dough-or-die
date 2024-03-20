extends Node2D
class_name gun

@export var bullet: PackedScene
@export var bulletCount: int = 1
@export_range(0, 360) var arc: float = 0
@export_range(0, 20) var fireRate: float = 2.0

var can_shoot = true

func shoot():
	if can_shoot:
		can_shoot = false
		for i in bulletCount:
			var newBullet = bullet.instantiate()
			newBullet.position = global_position
			var arcRad = deg_to_rad(arc)
			var increment = arcRad / (bulletCount - 1)
			newBullet.global_rotation = (
				global_rotation +
				increment * i -
				arcRad / 2
			)
			get_tree().root.call_deferred("add_child", newBullet)
		await get_tree().create_timer(1 / fireRate).timeout
		can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
