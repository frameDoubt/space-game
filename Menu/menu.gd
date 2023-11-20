extends Control

signal exit

@onready var inspect_sound = $InspectAudioStreamPlayer2D
@onready var button_sound = $ClickAudioStreamPlayer2D
@onready var slider_start_sound = $SliderStartAudioStreamPlayer2D
@onready var slider_end_sound = $SliderEndAudioStreamPlayer2D
@onready var slider_change_sound = $SliderChangeAudioStreamPlayer2D
@onready var toggle_off_sound = $ToggleOffAudioStreamPlayer2D

@onready var starbasesSlider = $SettingsMarginContainer/VBoxContainer/AlliesMarginContainer/MarginContainer/VBoxContainer/GridContainer/HSlider
@onready var outpostsSlider = $SettingsMarginContainer/VBoxContainer/AlliesMarginContainer/MarginContainer/VBoxContainer/GridContainer/HSlider2
@onready var kingonsSlider = $SettingsMarginContainer/VBoxContainer/AlliesMarginContainer/MarginContainer/VBoxContainer/GridContainer/HSlider3
@onready var rulanWarbirdsSlider = $SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider
@onready var rulanSuperhawksSlider = $SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider2
@onready var cardaianDestroyersSlider = $SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider3
@onready var fengiMauraudersSlider = $SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider4
@onready var cubeShipsToggle = $SettingsMarginContainer/VBoxContainer/ModifiersMarginContainer3/MarginContainer/VBoxContainer/GridContainer/CheckButton
@onready var clusterSimilarTypesToggle = $SettingsMarginContainer/VBoxContainer/ModifiersMarginContainer3/MarginContainer/VBoxContainer/GridContainer/CheckButton2

func _ready():
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

func on_button_hover():
	inspect_sound.play()
	
func on_button_pressed():
	button_sound.play()
	
func on_slider_start_drag():
	slider_start_sound.play()
	
func on_slider_end_drag(_value_changed):
	slider_end_sound.play()
	
func on_slider_changed(_value):
	slider_change_sound.play()
	
func on_toggle_toggled(value):
	if value:
		on_button_pressed()
	else:
		toggle_off_sound.play()

func on_text_changed(_value):
	slider_change_sound.play()
	
func on_text_submitted(_value):
	button_sound.play()

func _on_play_button_pressed():
	save_settings()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_button_pressed():
	emit_signal("exit")
	get_tree().quit()

func save_settings():
	var tableName = "Difficulty"

	database.db_memory.create_table(tableName, {
		"id": {"data_type": "int", "primary_key": true, "not_null": true},
		"Starbases": {"data_type": "int", "not_null": true, "unique": true},
		"Outposts": {"data_type": "int", "not_null": true, "unique": true},
		"Kingons": {"data_type": "int", "not_null": true, "unique": true},
		"RulanWarbirds": {"data_type": "int", "not_null": true, "unique": true},
		"RulanSuperhawks": {"data_type": "int", "not_null": true, "unique": true},
		"CardaianDestroyers": {"data_type": "int", "not_null": true, "unique": true},
		"FengiMaurauders": {"data_type": "int", "not_null": true, "unique": true},
		"CubeShips": {"data_type": "int", "not_null": true, "unique": true},
		"ClusterSimilarTypes": {"data_type": "int", "not_null": true, "unique": true}
	})
	database.db_memory.insert_rows(tableName, [
		{ "id":1, "Starbases": starbasesSlider.value, "Outposts": outpostsSlider.value, "Kingons": kingonsSlider.value, 
		"RulanWarbirds": rulanWarbirdsSlider.value, "RulanSuperhawks": rulanSuperhawksSlider.value,
		"CardaianDestroyers": cardaianDestroyersSlider.value, "FengiMaurauders": fengiMauraudersSlider.value, 
		"CubeShips": cubeShipsToggle.is_pressed(), "ClusterSimilarTypes": clusterSimilarTypesToggle.is_pressed() }
		])
	database.db_memory.query("select * from " + tableName)
	print(database.db_memory.query_result)
