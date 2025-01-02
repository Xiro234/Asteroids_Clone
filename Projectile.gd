extends CharacterBody2D
class_name Projectile

@export var speed = 800

var direction = Vector2.ZERO

func _ready():
	velocity += direction * speed

func set_direction(newDirection: Vector2):
	self.direction = newDirection.normalized()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

	if(collision):
		var collider = collision.get_collider()

		collider.hit()
		queue_free()
