extends Label

func _ready():
	text = "0" # initial value

func _on_h_slider_value_changed(value):
	text = str(value)
