extends Node2D
@export var xp_item = PackedScene
var xp_value


func drop_loot(xp_value):
	var random = randi_range(1,4)
	if random > 0:
		print("loot dropping!")
		var xp_scene = load("res://Drops/XP/xp_drop.tscn")
		var xp_drop = xp_scene.instantiate()
		xp_drop.xp_value = xp_value
		xp_drop.global_position = get_parent().global_position
		call_deferred("_drop_loot_deferred", xp_drop)
	
		#TODO create loot scene and instantiate here, then make child of root scene as we are destroying this one
func _drop_loot_deferred(xp_drop):
		get_parent().get_parent().add_child(xp_drop)
