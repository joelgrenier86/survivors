extends Node2D


##@export var ability_list : Array [PackedScene]
##to avoid the requirement of a full spell catalog for testing im just ramming the spellnames in here
var ability_list = ["fireball", "lightning bolt","fan of knives", "bladewhirl", "chain lightning", "poison arrow", "jumping flame"]
var player_upgradeables = ["speed", "cooldown reduction", "projectiles", "crit chance", "crit damage", "chance to apply status"]
var upgrades = [ability_list,player_upgradeables]


func generate_random_upgrade():
	#var upgrade_type = randi_range(0,1)
	var upgrade_type = 1
	var type_name
	var list_size = len(upgrades[upgrade_type])
	var upgrade_index = randi_range(0,list_size-1)
	var upgrade = upgrades[upgrade_type][upgrade_index]
	match upgrade_type:
		0: type_name = "new_ability"
		1: type_name = "player_upgrade"
		2: type_name = "ability_upgrade"
			
	#return [upgrade, type_name]
	return ["cooldown_reduction", type_name]
		
func get_abilities():
	return ability_list



	

	




