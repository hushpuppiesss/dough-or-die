extends Marker2D

@export var Enemy: PackedScene
@export var small_timer_randomization: bool = false

@onready var timer = $Timer
var spawnTime = true

func _ready():
	pass

func _process(delta):
	if spawnTime == true:
		spawn()
		
		spawnTime = false
		timer.start()

func spawn():
	var temp = Enemy.instantiate()
	temp.position = self.position
	add_sibling(temp)

func _on_timer_timeout():
	spawnTime = true
