extends Node2D

var projectileScene = preload("res://Characters/Components/Projectile.tscn")

func _ready():
	pass

func _unhandled_input(event):
	if (event.is_action_pressed("fire")):
		var projectile = projectileScene.instantiate()
		get_parent().add_sibling(projectile)
		projectile.global_position = self.global_position
		projectile.rotation = self.get_parent().rotation
		
		print("fire")
