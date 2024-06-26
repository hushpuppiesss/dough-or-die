extends Sprite2D
class_name Gun

@export var bullet: PackedScene
@export var bulletCount: int = 1
@export_range(0, 360) var arc: float = 0
@export_range(0, 20) var fireRate: float = 2.0

@onready var player = get_parent()
@export var barrel_origin: Node2D
@onready var bubble = $"../bubble"

var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	
func _physics_process(delta):
	# rotating effect
	var mouse_pos = get_global_mouse_position()
	# determines mouse relative to player position
	if mouse_pos.x < player.global_position.x:
		flip_v = true
		position.x = lerp(position.x, player.global_position.x - 30, 0.5)
		position.y = lerp(position.y, player.global_position.y - 10, 0.5)
	if mouse_pos.x > player.global_position.x:
		flip_v = false
		position.x = lerp(position.x, player.global_position.x + 30, 0.5)
		position.y = lerp(position.y, player.global_position.y - 10, 0.5)
	# looks at mouse position
	look_at(mouse_pos)
	
	
func shoot():
	if can_shoot:
		can_shoot = false
		for i in bulletCount:
			var newBullet = bullet.instantiate()
			newBullet.position = barrel_origin.global_position if barrel_origin else global_position
			
			if bulletCount == 1:
				newBullet.rotation = global_rotation
			else:
				var arcRad = deg_to_rad(arc)
				var increment = arcRad / (bulletCount - 1)
				newBullet.global_rotation = (
					global_rotation +
					increment * i -
					arcRad / 2
				)
			# adds bullet as a child
			get_tree().root.call_deferred("add_child", newBullet)
			# plays bubble sound
			bubble.play()
		await get_tree().create_timer(1 / fireRate).timeout
		can_shoot = true

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
