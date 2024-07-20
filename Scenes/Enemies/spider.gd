extends Node2D

@onready var auto_move_component = $AutoMoveComponent
@export var speed: int = 70

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	auto_move_component.handle_direction_switch()
	position.x += speed * delta * auto_move_component.get_direction()
	pass
