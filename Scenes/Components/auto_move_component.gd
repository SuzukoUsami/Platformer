extends Node2D
class_name AutoMoveComponent

@export var sprite: AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down = $RayCastDown

var direction = -1 #Change to enum

func get_direction() -> int:
	return direction
 
# Checks raycasts and switches direction if neededf
func handle_direction_switch() -> void:
	if ray_cast_left.is_colliding() or not ray_cast_down.is_colliding():
		switch_direction()

# Rotates raycasts and flips sprite
func switch_direction() -> void:
	ray_cast_down.position.x *= -1
	ray_cast_left.rotate(PI)
	direction *= -1
	sprite.set_flip_h(not sprite.flip_h)
