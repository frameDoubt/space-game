extends Node


var tableName = "DifficultyPresets"

@onready var difficultyButtonContainer = $PresetMarginContainer/MarginContainer/VBoxContainer

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
	print(database.db.query_result)
