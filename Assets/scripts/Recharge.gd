extends Node2D

var bar
var value

# Called when the node enters the scene tree for the first time.
func _ready():
	value = 0.0
	bar = get_node("bar")
	pass # Replace with function body.

func findCastle():
	var arr = Array()
	for N in get_node("../../BUILDINGS").get_children():
		if (N.allegence == "player"):
			arr.append(N)
	return arr[(randi() % arr.size())]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bar.size.x = value*300
	value += delta * 0.05
	if (value >= 1.0):
		value = 0
