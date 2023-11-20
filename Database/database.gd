extends Node

var db_persistent : SQLite = null
var db_persistent_name := "res://Database/database.db"

var db_memory : SQLite = null
var db_memory_name = ":memory:"

const verbosity_level : int = SQLite.VERBOSE

func _ready():
	# Create the database.
	db_persistent = SQLite.new()
	db_persistent.path = db_persistent_name
	db_persistent.verbosity_level = verbosity_level
	db_persistent.open_db()
	
	db_memory = SQLite.new()
	db_memory.path = db_memory_name
	db_memory.verbosity_level = verbosity_level
	db_memory.open_db()
	

func close_database():
	print ("close database")
# Close the current database
	db_persistent.close_db()
	db_memory.close_db()

func _exit_tree():
	close_database()
