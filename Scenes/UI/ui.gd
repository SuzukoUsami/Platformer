extends CanvasLayer

# Coins color change
var transparent: Color = Color("ffffff4e")
var orginal: Color = Color("ffffff")

#PLAYER LIFE
@onready var heart_full = preload("res://graphics/Platformer Art Deluxe/Base pack/HUD/hud_heartFull.png")
@onready var heart_half = preload("res://graphics/Platformer Art Deluxe/Base pack/HUD/hud_heartHalf.png")
@onready var heart_empty = preload("res://graphics/Platformer Art Deluxe/Base pack/HUD/hud_heartEmpty.png")

@onready var health_text: Label = $HeartControl/HealthLabel
@onready var hearts_container: HBoxContainer = $HeartControl/HeartsContainer
#@onready var health_image: TextureRect = $HeartContainers/HBoxContainer/TextureRect

#COINS
@onready var coin_text: Label = $CoinCounter/Coin/CoinLabel
@onready var coin_image: TextureRect = $CoinCounter/Coin/TextureRect



func _ready():
	Globals.connect("health_change", update_health_text)
	update_health_text()
	update_hearts_textures()
	Globals.connect("amount_change", update_coin_text)
	update_coin_text()
	
	#health_image.texture = heart_full
	
# HEALTH
func update_health_text():
	health_text.text = str(Globals.health)

func update_hearts_textures():
	var hearts = hearts_container.get_children() # [TR, TR2, TR3]
	print(hearts)
	
	for heart:TextureRect in hearts:
		heart.texture = heart_full
		pass

#COINS 
func update_coin_text():
	coin_text.text = str(Globals.coins_amount)
	update_color(Globals.coins_amount, coin_text, coin_image)

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 1:
		icon.modulate = transparent
		label.modulate = transparent
	else:
		icon.modulate = orginal
		label.modulate = orginal
	
