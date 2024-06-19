extends CanvasLayer

#color change
var transparent: Color = Color("ffffff4e")
var orginal: Color = Color("ffffff")

@onready var coin_text: Label = $CoinCounter/Coin/CoinLabel
@onready var coin_image: TextureRect = $CoinCounter/Coin/TextureRect

func _ready():
	Globals.connect("amount_change", update_amount_text)
	update_coin_text()


func update_coin_text():
	coin_text.text = str(Globals.coins_amount)
	update_color(Globals.coins_amount, coin_text, coin_image)
	
	
func update_amount_text():
	update_coin_text()

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 1:
		icon.modulate = transparent
		label.modulate = transparent
	else:
		icon.modulate = orginal
		label.modulate = orginal
	
