extends Node

signal amount_change
signal health_change

func _ready():
	pass

const PLAYER_NAME = "GreenAlien"

var current_level: String = "res://Scenes/Levels/level1.tscn"

var health: int = 6:
	set(value):
		health = value
		health_change.emit()

var coins_amount: int = 0:
	set(value):
		coins_amount = value
		amount_change.emit()

#func hit_player(body):
	#health -= 1
	#if health < 1 and body.name == Globals.PLAYER_NAME:
		#body.get_node("CollisionPolygon2D").queue_free()
		

func change_level(target_level: String) -> void:
	get_tree().change_scene_to_file(target_level)
	coins_amount = 0
	health = 6
	current_level = target_level
	#print("play transition animations")
	
var target


	
func save_game():
	#print(last_completed_level)
	var config = ConfigFile.new()
	config.set_value("Player1", "last_level", current_level)
	config.save("user://saves.cfg")
	
func load_game():
	print("load")

	var config = ConfigFile.new()

	config.load("user://saves.cfg")

	var last_save = config.get_value("Player1", "last_level")
	print(last_save)

	change_level(last_save)
	#print(last_save)



var player_position: Vector2
var door_position: Vector2
