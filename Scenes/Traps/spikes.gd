extends StaticBody2D



func _on_area_2d_body_entered(body):
	if (body.name == "GreenAlien"):
		Globals.hit_player(body)
		body.bounce()
	
	
