extends Node2D

var projectileScene = preload("res://Characters/Components/Projectile.tscn")

func _ready():
	pass

func _unhandled_input(event):
	if (event.is_action_pressed("fire")):
		var projectile = projectileScene.instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = self.global_position
		
		print("fire")
