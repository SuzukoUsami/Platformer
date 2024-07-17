extends Node2D


func _on_secret_areas_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		$SecretRoom/SecretTileMap.modulate = Color(0.1, 0.1, 0.1, 0.0)


func _on_secret_areas_body_exited(body):
	if (body.name == Globals.PLAYER_NAME):
		$SecretRoom/SecretTileMap.modulate = Color(1, 1, 1, 1)
