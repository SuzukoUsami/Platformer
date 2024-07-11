extends Node

signal amount_change
signal health_change

var health: int = 6:
	set(value):
		health = value
		health_change.emit()

func hit_player(body):
	health -= 1
	if health < 1 and body.name == "GreenAlien":
		body.get_node("CollisionPolygon2D").queue_free()
		#body.get_tree().reload_current_scene()

var coins_amount: int = 0:
	set(value):
		coins_amount = value
		amount_change.emit()

var player_position: Vector2
