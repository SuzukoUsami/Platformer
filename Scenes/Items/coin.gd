extends Node2D

var coin_value: int = 15

func _on_area_2d_body_entered(_body):
	Globals.coins_amount += 15
	print("gold")
	queue_free()
