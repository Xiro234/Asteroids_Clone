extends Node2D

@onready var stars: ColorRect = $Stars
@export var camera: Node2D

func _process(delta):
	position = Vector2(camera.get_screen_center_position().x - stars.size.x / 2, camera.get_screen_center_position().y - stars.size.y / 2)
	stars.material.set_shader_parameter("position", position)
