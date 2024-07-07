extends Control
var upgrade_type

func configure_card(card_info):
	$TitlePanel/CardName.text = card_info[0]
	upgrade_type = card_info[1]


func _on_button_pressed():
	Events.select_upgrade.emit([$TitlePanel/CardName.text, upgrade_type])
