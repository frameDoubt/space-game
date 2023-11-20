extends Control

signal exit

@onready var inspect_sound = $InspectAudioStreamPlayer2D2
@onready var button_sound = $ClickAudioStreamPlayer2D

func _ready()->void:
	var buttons: Array = get_tree().get_nodes_in_group("Buttons")
	for inst in buttons:
		inst.mouse_entered.connect(on_button_hover)
		inst.pressed.connect(on_button_pressed)

func on_button_hover()->void:
	inspect_sound.play()
	
func on_button_pressed()->void:
	button_sound.play()
	
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_button_pressed():
	emit_signal("exit")
	get_tree().quit()
