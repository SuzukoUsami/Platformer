extends PathFollow2D


var speed = 0.1

func _process(delta):
	progress_ratio += speed * delta


func _on_hitbox_body_entered(_body):
	queue_free()
