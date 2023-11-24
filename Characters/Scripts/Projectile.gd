extends CharacterBody2D

const speed = 350
var direction = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	var collision = move_and_collide(transform.basis_xform(Vector2.UP) * speed * delta)
	if collision:
		print("I collided with ", collision.get_collider().name)
