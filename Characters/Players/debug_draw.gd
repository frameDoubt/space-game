extends Node2D

var colors = {
	'BLUE': Color(.216, .474, .702),
	'RED': Color(1.0, .329, .298),
	'YELLOW': Color(.867, .91, .247),
	'GREEN': Color(.054, .718, .247)
}

var WIDTH = 15
var parent = null

func _ready():
	parent = get_parent()
	set_process(true)
	set_process_input(true)

func input(event):
	if event.is_anything_pressed():
		set_visible(true)

func _process(_delta):
	set_rotation(parent.get_rotation())
	queue_redraw()

func _draw():
	draw_arrow(parent.get_linear_velocity(), Vector2(), 1.0, 'YELLOW')
	
func draw_arrow(vector, pos, scale, color):
	color = colors[color]
	if vector.length() == 0:
		return
	draw_line(pos * scale, vector * scale, color, WIDTH)
	#var dir = vector.normalized()
	draw_circle(pos, 5, color)
