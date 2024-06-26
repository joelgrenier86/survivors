extends CanvasLayer


func generate_loot_options():
	var loot_panels =  [$LootSelectControl/LootPanelContainer/AbilityPanel1/LootCard1, $LootSelectControl/LootPanelContainer/AbilityPanel2/LootCard2,$LootSelectControl/LootPanelContainer/AbilityPanel3/LootCard3]
	for i in range(loot_panels.size()):
		var loot_option = $AbilityCatalogComponent.generate_random_upgrade()
		loot_panels[i].set_card_title(loot_option)
	

	
