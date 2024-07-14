extends Node

signal amount_change
signal health_change

func _ready():
	pass

const PLAYER_NAME = "GreenAlien"

var health: int = 6:
	set(value):
		health = value
		health_change.emit()

var coins_amount: int = 0:
	set(value):
		coins_amount = value
		amount_change.emit()

var last_completed_level: int = 0:
	set(value):
		last_completed_level = value
		pass

var player_position: Vector2

func hit_player(body):
	health -= 1
	if health < 1 and body.name == Globals.PLAYER_NAME:
		body.get_node("CollisionPolygon2D").queue_free()
		

func change_level(target_level: String) -> void:
	get_tree().change_scene_to_file(target_level)
	print("reset HP and $$$")
	print("play transition animations")
	
	


