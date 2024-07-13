extends Node2D

var speed = 60
var direction = -1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var sprite_slime = $Sprite2D


func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		sprite_slime.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		sprite_slime.flip_h = true
		
	position.x += speed * delta * direction

func _on_hitbox_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			queue_free()
			body.bounce(1)
		else:
			Globals.hit_player(body)
	
