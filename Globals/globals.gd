extends Node

signal amount_change

var coins_amount: int = 0:
	set(value):
		coins_amount = value
		amount_change.emit()

