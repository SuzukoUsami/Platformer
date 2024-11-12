extends Node2D

@onready var luceg_dialog = $HowToPet

var active:bool = false

func _process(delta):
	if (Input.is_action_just_pressed("primary action") and active):
		print_debug("Mrrrr..yyy..")


func _on_notice_area_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		luceg_dialog.show()
		active = true
		
	if (Input.is_action_just_pressed("primary action")):
		print_debug("Mrrrr..yyy..")

func _on_notice_area_body_exited(body):
	if (body.name == Globals.PLAYER_NAME):
		luceg_dialog.hide()
		active = false
