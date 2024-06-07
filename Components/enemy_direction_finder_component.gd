extends Node2D
enum Dirs {LEFT,RIGHT,UP,DOWN}
@onready var player = get_tree().get_first_node_in_group("player")
var dir = Dirs.DOWN
signal enemy_direction(Vector2)

func _ready():
	pass
func _process(_delta):
	var direction = acquire_target_position()

	if direction.x < 0:
		dir = Dirs.LEFT
	elif direction.x > 0:
		dir = Dirs.RIGHT
	elif direction.y < 0:
		dir = Dirs.UP
	elif direction.y > 0:
		dir = Dirs.DOWN

func acquire_target_position():
	if !player:
		player = get_tree().get_first_node_in_group("player")
	return get_parent().global_position.direction_to(player.global_position)	

func get_animation_direction():
	return dir
