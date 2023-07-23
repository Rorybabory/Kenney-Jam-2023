extends Camera2D

var shake_amount = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shake(amnt):
	shake_amount = amnt
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_offset(Vector2( \
		randf_range(-1.0, 1.0) * shake_amount, \
		randf_range(-1.0, 1.0) * shake_amount \
	))
	if (shake_amount > 0.0):
		shake_amount-=delta*10.0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			position -= event.relative
	
