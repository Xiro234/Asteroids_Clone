extends CharacterBody2D
@onready var camera: Camera2D = $Camera
@onready var trail: GPUParticles2D = $Trail
@onready var gunManager: = $GunManager
@onready var hitbox = $CollisionPolygon2D
@onready var sprite = $Sprite2D

@onready var thrustSound: AudioStreamPlayer2D = $ThrustSound
@onready var destroySound: AudioStreamPlayer2D = $DestroySound

@onready var gibLocations = [$ShipPartLocation1, $ShipPartLocation2, $ShipPartLocation3, $ShipPartLocation4]
@export var gib: PackedScene

var destroyed = false

const ACCEL = 10.0
const MAX_SPEED = 500.0
const TURN_SPEED = 0.025
const SHOOT_INTERVAL = 125

const TRAIL_SPEED = 100.0

func _ready():
	camera.position = position

func handle_input():
	if Input.is_action_pressed("Forward"):
		velocity += ACCEL * Vector2(0,-1).rotated(rotation)
		trail.emitting = true
		if(!thrustSound.playing):
			thrustSound.play()
	else:
		trail.emitting = false
		if(thrustSound.playing):
			thrustSound.stop()

	if Input.is_action_pressed("Left"):
		rotation -= TURN_SPEED

	if Input.is_action_pressed("Right"):
		rotation += TURN_SPEED

	velocity = velocity.limit_length(MAX_SPEED)

	if Input.is_action_pressed("Fire"):
		gunManager.shoot(velocity)

func _physics_process(delta):
	if destroyed:
		return
		
	handle_input()
	var collision = move_and_collide(velocity * delta)

	if(collision):
		destroy()

func destroy():
	if destroyed:
		return

	sprite.visible = false
	hitbox.disabled = true
	gunManager.visible = false
	trail.emitting = false

	for i in range(gibLocations.size()):
		var gibInstance = gib.instantiate()
		gibInstance.position = gibLocations[i].position
		gibInstance.partNumber = i + 1
		gibInstance.linear_velocity = velocity
		add_child(gibInstance)

	destroyed = true

	destroySound.play()
	thrustSound.stop()

	Signals.emit_signal("game_over")
