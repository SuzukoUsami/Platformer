extends Node2D

var coin_value: int = 5

func _on_area_2d_body_entered(_body):
	Globals.coins_amount += 5
	queue_free()
