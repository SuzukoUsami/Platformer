extends Node2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var ray_cast_down_right = $RayCastDownRight
@onready var sprite_slime = $Sprite2D

var speed = 60
var direction = -1

var auto_move: bool

func _ready():
	auto_move = get_meta("auto_move", true)

func _process(delta):
	if ray_cast_right.is_colliding() or ray_cast_left.is_colliding():
		switch_direction()
		
	if auto_move and (not ray_cast_down_left.is_colliding() or not ray_cast_down_right.is_colliding()):
			switch_direction()
		
	position.x += speed * delta * direction

func switch_direction() -> void:
	direction *= -1
	sprite_slime.set_flip_h(not sprite_slime.flip_h)

func _on_hitbox_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			queue_free()
			body.bounce(1)
		else:
			Globals.hit_player(body)
	
