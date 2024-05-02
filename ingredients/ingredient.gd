extends CharacterBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var player = InteractionManager.player

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_pick_up")

func _pick_up():
	if CookingManager.can_pick_up:
		CookingManager.item_in_hand = self
		CookingManager._picked_up()
		reparent(player)
		# perfect coordinates
		#self.position.x = 0
		#self.position.y = 3
		
# if dropped
func _input(event):
	if event.is_action_pressed("drop"):
		if CookingManager.carrying == true:
			reparent(InteractionManager.world)
			self.position = position
			CookingManager._put_down()
			CookingManager.item_in_hand = null
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# checking if player is carrying something
	if CookingManager.carrying:
		# cehcking the direction
		if player.velocity.y < 0: # down
			self.visible = true
			self.position.x = 0
			self.position.y = 3
		if player.velocity.x < 0: # left 
			self.visible = true
			self.position.x = -16
			self.position.y = -3
		if player.velocity.x > 0: # right
			self.visible = true
			self.position.x = 16
			self.position.y = -3
		if player.velocity.y < 0: # up
			self.visible = false
	
