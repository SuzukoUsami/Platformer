extends Node2D

var coin_value: int = 15

#func _process(_delta):
	#var tween = get_tree().create_tween()
	#tween.tween_property($Sprite2D, "position", Vector2(0, -200), 10)
	#tween.tween_property($Sprite2D, "position", Vector2(0, 0), 10)

func _on_area_2d_body_entered(_body):
	Globals.coins_amount += 10
	queue_free()
