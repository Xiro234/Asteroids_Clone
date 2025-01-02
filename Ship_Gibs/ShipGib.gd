extends RigidBody2D

@export var partNumber := 1

func loadTexture(num: int):
	$Sprite2D.set_texture(load("res://Ship_Gibs/ShipPart" + str(num) + ".svg"))

func loadCollision(num: int):
	var poly: ConvexPolygonShape2D = load("res://Ship_Gibs/Ship_Gib_Collisions/ShipPart" + str(num) + ".tres")
	$CollisionPolygon2D.set_polygon(poly.points)

# Called when the node enters the scene tree for the first time.
func _ready():
	loadTexture(partNumber)
	loadCollision(partNumber)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
