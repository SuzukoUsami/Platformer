extends CanvasLayer

# Coins color change
var transparent: Color = Color("ffffff4e")
var orginal: Color = Color("ffffff")

#PLAYER LIFE
@onready var heart_full = preload("res://graphics/Platformer Art Deluxe/Base pack/HUD/hud_heartFull.png")
@onready var heart_half = preload("res://graphics/Platformer Art Deluxe/Base pack/HUD/hud_heartHalf.png")
@onready var heart_empty = preload("res://graphics/Platformer Art Deluxe/Base pack/HUD/hud_heartEmpty.png")

@onready var hearts_container: HBoxContainer = $HeartControl/HeartsContainer

#COINS
@onready var coin_text: Label = $CoinCounter/Coin/CoinLabel
@onready var coin_image: TextureRect = $CoinCounter/Coin/TextureRect

func _ready():
	Globals.connect("health_change", update_hearts_textures)
	update_hearts_textures()
	Globals.connect("amount_change", update_coin_text)
	update_coin_text()
	
# HEALTH
func update_hearts_textures():
	var hearts = hearts_container.get_children() # [TR, TR2, TR3]
	
	var temp_hp = Globals.health
	# Loop for all heart containers and apply correct texture
	for current_heart: TextureRect in hearts:
		if temp_hp >= 2:
			current_heart.texture = heart_full
			temp_hp -= 2
			continue
		
		if temp_hp == 1:
			current_heart.texture = heart_half
			temp_hp -= 1
			continue
		
		if temp_hp == 0:
			current_heart.texture = heart_empty
			continue
		

#COINS 
func update_coin_text():
	coin_text.text = str(Globals.coins_amount)
	update_color(Globals.coins_amount, coin_text, coin_image)

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 0:
		icon.modulate = transparent
		label.modulate = transparent
	else:
		icon.modulate = orginal
		label.modulate = orginal
	
