extends Node2D

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func move(dir):
	position += inputs[dir] * 16;
func _unhandled_input(event):
	for dir in inputs.keys():
		if (event.is_action_pressed(dir)):
			move(dir);
	
