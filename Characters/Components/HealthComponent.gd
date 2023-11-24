extends CollisionShape2D

signal died
#signal healed
signal damaged
signal health_changed(curr_health, max_health)

@export var max_health = 30
@export var verbose = false

@onready var curr_health = max_health

func _ready():
	health_changed.emit(curr_health, max_health)

func hurt(damage):
	if curr_health <= 0:
		return
	curr_health -= damage
	if curr_health <= 0:
		died.emit()
	else:
		damaged.emit()
	health_changed.emit(curr_health, max_health)

