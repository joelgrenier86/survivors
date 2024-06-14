extends Node2D


@export var enemy_scenes : Array[PackedScene] 

@onready var player = get_tree().get_first_node_in_group("player")

signal spawn_monsters(num)
var spawn_number
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_number=2





func _on_spawn_timer_timeout():
	
	for i in range(0,spawn_number):
		spawn_monster()
	
func get_random_position():
	var enemies = []
	var vpr = get_viewport_rect().size * randf_range(1.1,1.4)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var side = ["up","down", "left", "right"].pick_random()
	var spawn1 = Vector2.ZERO
	var spawn2 = Vector2.ZERO
	match side:
		"up":
			spawn1 = top_left
			spawn2 = top_right
		"down":
			spawn1 = bottom_left
			spawn2 = bottom_right
		"left":
			spawn1 = top_left
			spawn2 = bottom_left
		"right":
			spawn1 = top_right
			spawn2 = bottom_right
	var x_coord = randf_range(spawn1.x, spawn2.x)
	var y_coord = randf_range(spawn1.y, spawn2.y)
	return Vector2(x_coord, y_coord)
func spawn_monster():
	#var enemy_picker = 4
	var enemy_picker = randi_range(0,enemy_scenes.size()-1)
	var enemy = enemy_scenes[enemy_picker].instantiate()
	enemy.global_position = get_random_position()
	
	
	add_child(enemy)
