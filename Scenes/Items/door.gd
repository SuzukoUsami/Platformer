extends Node2D


const DOOR_CLOSED_MID = preload("res://graphics/Platformer Art Deluxe/Base pack/Tiles/door_closedMid.png")
const DOOR_CLOSED_TOP = preload("res://graphics/Platformer Art Deluxe/Base pack/Tiles/door_closedTop.png")

const DOOR_OPEN_MID = preload("res://graphics/Platformer Art Deluxe/Base pack/Tiles/door_openMid.png")
const DOOR_OPEN_TOP = preload("res://graphics/Platformer Art Deluxe/Base pack/Tiles/door_openTop.png")

@onready var sprite_mid = $SpriteMid
@onready var sprite_top = $SpriteTop
@onready var ui = $HBoxContainer
@onready var label = $HBoxContainer/Label
@onready var particles = $GPUParticles2D

var required_coins : int = 15

func _ready():

	Globals.connect("amount_change", update_coins_amount)
	update_coins_amount()
	label.text = str(required_coins)
	

func update_coins_amount():
	if(Globals.coins_amount >= required_coins):
		sprite_mid.texture = DOOR_OPEN_MID
		sprite_top.texture = DOOR_OPEN_TOP
		particles.visible = true
	else:
		sprite_mid.texture = DOOR_CLOSED_MID
		sprite_top.texture = DOOR_CLOSED_TOP
		particles.visible = false
	pass


func _on_area_2d_body_entered(body):
	if body.name == Globals.PLAYER_NAME:
		if Globals.coins_amount >= required_coins:
			print("You may pass through the door")
		else:
			ui.visible = true


func _on_area_2d_body_exited(body):
	if body.name == Globals.PLAYER_NAME:
		ui.visible = false
