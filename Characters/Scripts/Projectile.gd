extends CharacterBody2D

const speed = 200
var direction = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	move_and_collide(Vector2.UP * speed)
