extends RigidBody2D

@onready var emitter = $Explosion
@onready var timer = $Timer
@onready var hitbox = $CollisionPolygon2D
@onready var sprite = $Sprite2D
@onready var destroySound: AudioStreamPlayer = $DestroySound

var ship = null

@export var asteroidNumber := 1
var counter = 0

func loadTexture(num: int):
	$Sprite2D.set_texture(load("res://Asteroid_Sprites/asteroid_" + str(num) + ".svg"))

func loadCollision(num: int):
	var poly: ConvexPolygonShape2D = load("res://Asteroid_Collisions/collision_asteroid_" + str(num) + ".tres")
	$CollisionPolygon2D.set_polygon(poly.points)

func hit():
	emitter.emitting = true
	sprite.visible = false
	hitbox.disabled = true
	timer.start()
	destroySound.play()
	Signals.emit_signal("asteroid_destroyed")
	
func _ready():
	asteroidNumber = randi() % 5 + 1
	loadTexture(asteroidNumber)
	loadCollision(asteroidNumber)

func _process(delta):
	if ship.position.distance_to(position) > 2500:
		queue_free()

func _on_timer_timeout():
	queue_free()
