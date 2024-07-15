extends StaticBody2D



func _on_area_2d_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		Globals.hit_player(body)
		body.hit_shader()
		body.bounce(1)
	
	
