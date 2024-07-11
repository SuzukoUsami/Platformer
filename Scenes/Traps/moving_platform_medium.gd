extends PathFollow2D


var speed = 0.1
@onready var collision_shape_2d = $Platform/CollisionShape2D
@onready var platform = $Platform

func _process(delta):
	progress_ratio += speed * delta

	print(platform.position, platform.global_position)
