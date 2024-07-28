extends Node2D

@onready var auto_move_component = $AutoMoveComponent

var speed = 50

func _physics_process(delta):
	auto_move_component.handle_direction_switch()
	position.x += speed * delta * auto_move_component.get_direction()
