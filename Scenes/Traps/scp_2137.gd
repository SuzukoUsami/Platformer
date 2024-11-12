extends Node2D


func _on_notice_area_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		print("Mrrrr..yyy..")
