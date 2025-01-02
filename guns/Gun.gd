extends Node2D
class_name Gun

@export var projectile: PackedScene
@onready var gunBarrel: Marker2D = $GunBarrel
@onready var shootTimer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer = $Sound

func shoot(playerVelocity: Vector2):
	if(shootTimer.is_stopped()):
		var projectileInstance = projectile.instantiate()
		projectileInstance.position = gunBarrel.global_position
		projectileInstance.set_direction(gunBarrel.global_position - global_position)
		projectileInstance.velocity += playerVelocity
		Signals.emit_signal("shoot_projectile", projectileInstance)

		sound.play()
		shootTimer.start()
