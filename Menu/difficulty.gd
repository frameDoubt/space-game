extends Node

var tableName = "DifficultyPresets"

@onready var difficultyButtonContainer = $PresetMarginContainer/MarginContainer/VBoxContainer
@onready var starbasesSlider = $"../SettingsMarginContainer/VBoxContainer/AlliesMarginContainer/MarginContainer/VBoxContainer/GridContainer/HSlider"
@onready var outpostsSlider = $"../SettingsMarginContainer/VBoxContainer/AlliesMarginContainer/MarginContainer/VBoxContainer/GridContainer/HSlider2"
@onready var kingonsSlider = $"../SettingsMarginContainer/VBoxContainer/AlliesMarginContainer/MarginContainer/VBoxContainer/GridContainer/HSlider3"
@onready var rulanWarbirdsSlider = $"../SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider"
@onready var rulanSuperhawksSlider = $"../SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider2"
@onready var cardaianDestroyersSlider = $"../SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider3"
@onready var fengiMauradersSlider = $"../SettingsMarginContainer/VBoxContainer/EnemiesMarginContainer2/MarginContainer/VBoxContainer/GridContainer/HSlider4"

func _ready():
	database.db.query("select * from " + tableName + ";")
	
	for i in range(0, database.db.query_result.size()):
		# setup button
		var button = Button.new()
		button.add_to_group("Buttons")
		button.text = database.db.query_result[i]["Name"]
		button.pressed.connect(on_button_pressed.bind(database.db.query_result[i]["ID"]))
		difficultyButtonContainer.add_child(button)

func on_button_pressed(id):
	database.db.query("select * from " + tableName + " where " + tableName + ".ID = " + str(id) + ";")
	starbasesSlider.value = database.db.query_result[0]["Starbases"]
	outpostsSlider.value = database.db.query_result[0]["Outposts"]
	kingonsSlider.value = database.db.query_result[0]["Kingons"]
	rulanWarbirdsSlider.value = database.db.query_result[0]["RulanWarbirds"]
	rulanSuperhawksSlider.value = database.db.query_result[0]["RulanSuperhawks"]
	cardaianDestroyersSlider.value = database.db.query_result[0]["CardaianDestroyers"]
	fengiMauradersSlider.value = database.db.query_result[0]["FengiMauraders"]
