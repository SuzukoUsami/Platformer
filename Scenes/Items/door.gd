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

signal player_used_door(target_level)

var required_coins : int 
var target_level : String 


func _ready(): 
	required_coins =  get_meta("required_coins", 0)
	target_level = get_meta("target_level", "res://Scenes/UI/main_menu.tscn")
	Globals.door_position = global_position
	
	Globals.connect("amount_change", update_coins_amount)
	update_coins_amount()
	label.text = str(required_coins)
	


func update_coins_amount():
	if(Globals.coins_amount >= required_coins):
		sprite_mid.texture = DOOR_OPEN_MID
		sprite_top.texture = DOOR_OPEN_TOP
		particles.set_emitting(true)
	else: 
		sprite_mid.texture = DOOR_CLOSED_MID
		sprite_top.texture = DOOR_CLOSED_TOP
		particles.set_emitting(false)
	pass

func change_level():
	Globals.change_level(target_level)

func _on_area_2d_body_entered(body):
	if body.name == Globals.PLAYER_NAME:
		if Globals.coins_amount >= required_coins:
			$TransitionLayer/AnimationPlayer.play("fade_to_black")
			await  $TransitionLayer/AnimationPlayer.animation_finished
			$TransitionLayer/AnimationPlayer.play("reveal")
			#await $TransitionLayer/AnimationPlayer.animation_finished
			call_deferred("change_level")
		else:
			ui.visible = true


func _on_area_2d_body_exited(body):
	if body.name == Globals.PLAYER_NAME:
		ui.visible = false
