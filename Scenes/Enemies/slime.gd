extends Node2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var ray_cast_down_right = $RayCastDownRight
@onready var sprite_slime = $AnimatedSprite2D

const shader = preload("res://Characters/green_alien.gdshader")

var speed = 60
var direction = -1

var auto_move: bool
var switched_direction_in_prev_frame: bool = false

func _ready():
	auto_move = get_meta("auto_move", true)

func _process(delta):
	if ray_cast_right.is_colliding() or ray_cast_left.is_colliding():
		switch_direction()
		
	if auto_move and (not ray_cast_down_left.is_colliding() or not ray_cast_down_right.is_colliding()):
		switch_direction()
		
	position.x += speed * delta * direction

func switch_direction() -> void:
	if switched_direction_in_prev_frame:
		switched_direction_in_prev_frame = false
	else:
		direction *= -1
		sprite_slime.set_flip_h(not sprite_slime.flip_h)
		switched_direction_in_prev_frame = true

func _on_hitbox_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			$AnimatedSprite2D.material.set_shader_parameter("progress", 0.6)
			$HitShaderTimer.start()
			#queue_free()
			body.bounce(1)
		else:
			body.hit_player()


func _on_hit_shader_timer_timeout():
	queue_free()
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
