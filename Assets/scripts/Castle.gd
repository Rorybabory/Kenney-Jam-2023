extends Node2D

var health = 1.0
@export var allegence : String
var gfx
var healthchild
var enemytex
var playertex
var hitscale = 40.0

# Called when the node enters the scene tree for the first time.
func _ready():
	healthchild = get_node("health")
	gfx = get_node("CastleWide")
	playertex = load("res://Assets/sprites/castle_player.png")
	enemytex = load("res://Assets/sprites/castle_enemy.png")
	resethealth()
	resetAllegence()
	pass # Replace with function body.

func hit(src):
	pass
func resethealth():
	health = randf_range(0.75, 1.0)
func resetAllegence():
	if (allegence == "enemy"):
		gfx.texture = enemytex
	else:
		gfx.texture = playertex

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthchild.scale.x = health*40

	if (health < 0.01):
		if (allegence == "enemy"):
			allegence = "player"
		else:
			allegence = "enemy"
		resetAllegence()
		resethealth()

