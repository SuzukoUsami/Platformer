extends Node2D


var fire_projectile_scene: PackedScene = preload("res://Scenes/Projectiles/fire_projectile.tscn")


func _ready():
	#ERROR?
	#for fire_worms in get_tree().get_nodes_in_group("FireWorms"):
		#fire_worms.connect("fire_projectile", _on_fire_worm_fire_projectile)
	pass

func  create_fire_projectile(pos, direction):
	var fire_projectile = fire_projectile_scene.instantiate() as Node2D
	fire_projectile.position = pos
	fire_projectile.direction = direction
	$Projectiles.add_child(fire_projectile)
	
func _on_fire_worm_fire_projectile(pos, direction):
	create_fire_projectile(pos, direction)
	

func _on_secret_areas_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		$SecretRoom/SecretTileMap.modulate = Color(0.1, 0.1, 0.1, 0.0)


func _on_secret_areas_body_exited(body):
	if (body.name == Globals.PLAYER_NAME):
		$SecretRoom/SecretTileMap.modulate = Color(1, 1, 1, 1)
