extends Node2D

@export var speed: int = 100

var direction:  Vector2 #= Vector2.UP

func _ready():
	$SelfDestructTimer.start()

func _process(delta):
	print(position, direction, speed)
	position += direction * speed * delta


func _on_hit_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		body.hit_player()
		queue_free()


func _on_self_destruct_timer_timeout():
	#queue_free()
	pass
