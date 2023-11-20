extends Control

signal exit

@onready var inspect_sound = $InspectAudioStreamPlayer2D
@onready var button_sound = $ClickAudioStreamPlayer2D
@onready var slider_start_sound = $SliderStartAudioStreamPlayer2D
@onready var slider_end_sound = $SliderEndAudioStreamPlayer2D
@onready var slider_change_sound = $SliderChangeAudioStreamPlayer2D
@onready var toggle_off_sound = $ToggleOffAudioStreamPlayer2D

func _ready()->void:
	var buttons: Array = get_tree().get_nodes_in_group("Buttons")
	for inst in buttons:
		inst.mouse_entered.connect(on_button_hover)
		inst.pressed.connect(on_button_pressed)

	var sliders: Array = get_tree().get_nodes_in_group("Sliders")
	for inst in sliders:
		inst.mouse_entered.connect(on_button_hover)
		inst.drag_started.connect(on_slider_start_drag)
		inst.drag_ended.connect(on_slider_end_drag)
		inst.value_changed.connect(on_slider_changed)
	
	var toggles: Array = get_tree().get_nodes_in_group("Toggles")
	for inst in toggles:
		inst.mouse_entered.connect(on_button_hover)
		inst.toggled.connect(on_toggle_toggled)
		
	var textInput: Array = get_tree().get_nodes_in_group("TextInput")
	for inst in textInput:
		inst.mouse_entered.connect(on_button_hover)
		inst.text_changed.connect(on_text_changed)
		inst.text_submitted.connect(on_text_submitted)

func on_button_hover()->void:
	inspect_sound.play()
	
func on_button_pressed()->void:
	button_sound.play()
	
func on_slider_start_drag():
	slider_start_sound.play()
	
func on_slider_end_drag(value_changed):
	slider_end_sound.play()
	
func on_slider_changed(value):
	slider_change_sound.play()
	
func on_toggle_toggled(value):
	if value:
		on_button_pressed()
	else:
		toggle_off_sound.play()

func on_text_changed(value):
	slider_change_sound.play()
	
func on_text_submitted(value):
	button_sound.play()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_button_pressed():
	emit_signal("exit")
	get_tree().quit()
