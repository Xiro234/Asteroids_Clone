extends Node

@export var camera: Node2D

@export var asteroidScene: PackedScene

@export var asteroid_spawn_distance: float = 400.0
@export var asteroid_add_interval: int = 1000

@export var asteroid_speed: int = 400
@export var asteroid_speed_range: int = 50

@onready var ship: Node2D = $Ship
@onready var hud = $HUD
var num_asteroid_shot = 0

var game_over = false

func _ready():
	Signals.asteroid_destroyed.connect(_on_asteroid_destroyed)
	Signals.game_over.connect(_on_game_over)

func _process(delta):
	if(Time.get_ticks_msec() % asteroid_add_interval == 0 and !game_over):
		add_asteroid()

	if Input.is_action_pressed("Restart") and game_over:
		restart()

func add_asteroid():
	var camera_position = camera.get_screen_center_position()

	var random_side = randf()
	var random_extreme = randf()

	var pos_x: float
	var pos_y: float

	if(random_side > 0.5):
		pos_x = randf_range(camera_position.x + camera.get_viewport_rect().size.x / 2, camera_position.x - camera.get_viewport_rect().size.x / 2)

		if random_extreme > 0.5: 
			pos_y = camera_position.y + camera.get_viewport_rect().size.y / 2 + asteroid_spawn_distance
		else: 
			pos_y = camera_position.y - camera.get_viewport_rect().size.y / 2 - asteroid_spawn_distance
	else:
		pos_y = randf_range(camera_position.y + camera.get_viewport_rect().size.y / 2, camera_position.y - camera.get_viewport_rect().size.y / 2)

		if random_extreme > 0.5: 
			pos_x = camera_position.x + camera.get_viewport_rect().size.x / 2 + asteroid_spawn_distance
		else: 
			pos_x = camera_position.x - camera.get_viewport_rect().size.x / 2 - asteroid_spawn_distance
		
	
	var asteroid = asteroidScene.instantiate()
	asteroid.position = Vector2(pos_x, pos_y)

	var direction_towards_ship = (ship.position - asteroid.position).normalized()
	asteroid.linear_velocity = direction_towards_ship * randi_range(asteroid_speed - asteroid_speed_range, asteroid_speed + asteroid_speed_range)


	asteroid.ship = ship
	add_child(asteroid)

func _on_asteroid_destroyed():
	num_asteroid_shot += 1
	hud.update_score(num_asteroid_shot)

func _on_game_over():
	hud.game_over()
	game_over = true

func restart():
	get_tree().reload_current_scene()
