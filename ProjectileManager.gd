extends Node2D

func _ready():
	Signals.shoot_projectile.connect(_on_shoot_projectile)

func _on_shoot_projectile(projectile: Projectile):
	add_child(projectile)