extends Node

var db : SQLite = null
var db_name := "res://Database/database.db"
const verbosity_level : int = SQLite.VERBOSE

func _ready():
	# Create the database.
	db = SQLite.new()
	db.path = db_name
	db.verbosity_level = verbosity_level
	db.open_db()

func close_database():
	print ("close database")
# Close the current database
	db.close_db()

func _exit_tree():
	close_database()
