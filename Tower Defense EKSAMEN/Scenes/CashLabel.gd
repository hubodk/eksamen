extends Control

var money = 50
onready var cash_label = $CashLabel

func _process(delta):
	cash_label.text = "Cash: " + str(money)
