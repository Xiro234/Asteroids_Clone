extends Node2D

@onready var leftGun: Gun = $BulletThrower
#var rightGun: Gun

func _ready():
	leftGun.position.x = $LeftGunPosition.position.x

func shoot(playerVelocity: Vector2):
	leftGun.shoot(playerVelocity)
	#rightGun.shoot()
