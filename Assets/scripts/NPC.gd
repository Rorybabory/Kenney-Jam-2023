extends Sprite2D

var target

var camera
var attacktimer = 0.0
var speed = 0.0

var attackrot = 0.0

var health = 1.0
var healthchild

var maintarget

var playertex
var enemytex
var hitscale = 10

var attacktime = 1.5
var lastallegence = ""
@export var allegence : String

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("../../Camera")
	if (camera == null):
		print("null camera")
	target = null
	speed = randi_range(50, 120)
	healthchild = get_node("health")
	playertex = load("res://Assets/sprites/npc_player.png")
	enemytex = load("res://Assets/sprites/npc_enemy.png")
	set_sprite()
func take_damage(src, amt):
	health -= amt
	target = src
func chase_target(delta):
	self.position += transform.x * delta * speed
func lookat_target(delta):
	var angle = (target.global_position - self.global_position).angle()
	self.global_rotation = lerp_angle(self.global_rotation, angle, delta*5.0)
func hit(src):
	target = src
func attack_target(delta):
	attacktimer += delta
	if (attacktimer > attacktime):
		attacktimer = 0
		attacktime = randf_range(1, 2)
		target.health-= 0.1
		if (target.hit):
			target.hit(self)
		camera.shake(5)
func find_target(delta):
	if (maintarget != null):
		target = maintarget
		return
	for npc in get_parent().get_children():
		if (npc.allegence == allegence):
			continue
		if (self.global_position.distance_to(npc.global_position) < 50):
			target = npc
	if (allegence == "player"):
		return
	
func set_sprite():
	if (allegence == "player"):
		self.texture = playertex
	else:
		self.texture = enemytex
func set_allegence(a):
	if (allegence != a):
		allegence = a;
		set_sprite()
func check_allegence():
	if (target != null):
		if (target.allegence == allegence):
			target = null
	if (maintarget != null):
		if (maintarget.allegence == allegence):
			maintarget = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_allegence()
	if (target != null):
		lookat_target(delta)
		var attackdistance = 40
		if (target.hitscale):
			attackdistance = target.hitscale
		if (self.global_position.distance_to(target.global_position) < attackdistance):
			attack_target(delta)
		else:
			chase_target(delta)
	else:
		find_target(delta)
	
	healthchild.scale.x = health*40
	if (health < 0.01):
		queue_free()
