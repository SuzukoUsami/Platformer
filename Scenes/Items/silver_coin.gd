extends Node2D

var coin_value: int = 10

func _on_area_2d_body_entered(_body):
	print("silver")
	queue_free()
