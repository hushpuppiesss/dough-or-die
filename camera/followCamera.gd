extends Camera2D

# having access to tilemap node
@export var tilemap: TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	# setting limits of the map
	# gets world size in terms of used rectangles
	var mapRect = tilemap.get_used_rect()
	# pixel size
	var tileSize = tilemap.cell_quadrant_size
	
	# world size in pixels
	var worldSizeInPixels = mapRect.size * tileSize
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
