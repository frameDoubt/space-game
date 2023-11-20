extends Control

signal exit

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_button_pressed():
	emit_signal("exit")
	get_tree().quit()
