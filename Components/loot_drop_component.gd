extends Node2D
@export var xp_item = PackedScene
var xp_value


func drop_loot(enemy_xp_value, enemy_drop_modifier):
	xp_value = enemy_xp_value
	roll_xp_drop(enemy_drop_modifier)
	roll_loot_drop(enemy_drop_modifier)
	

	
		#TODO create loot scene and instantiate here, then make child of root scene as we are destroying this one
func _drop_loot_deferred(xp_drop):
		get_parent().get_parent().add_child(xp_drop)
		
func roll_xp_drop(enemy_drop_modifier):
	var random = randi_range(1,74) * enemy_drop_modifier
	if random > 1:
		print("xp dropping!")
		var xp_scene = load("res://Drops/XP/xp_drop.tscn")
		var xp_drop = xp_scene.instantiate()
		xp_drop.xp_value = xp_value
		xp_drop.global_position = get_parent().global_position
		call_deferred("_drop_loot_deferred", xp_drop)
		
		
func roll_loot_drop(enemy_drop_modifier):
	var random = randi_range(1,4)
	if random > 4:
		print("loot dropping!")
		var loot_scene = load("res://Drops/Loot/loot_drop.tscn")
		var loot_drop = loot_scene.instantiate()
		loot_drop.generate_loot(enemy_drop_modifier)
		loot_drop.global_position = get_parent().global_position
		call_deferred("_drop_loot_deferred", loot_drop)
