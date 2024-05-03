extends Control

@onready var score_value = 0
@onready var scoreLabel = $score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scoreLabel.text = "%d" % score_value
