extends Node2D
enum Dirs {LEFT,RIGHT,UP,DOWN}
@export var direction_component : Node2D
@onready var enemy = get_parent()
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = direction_component.call("get_animation_direction")
	

	return direction
	
func get_animation(animation_name):
	if !direction:
		direction = direction_component.call("get_animation_direction")
	match direction:
		Dirs.LEFT:
			
			return "walk_left"
		Dirs.RIGHT:
			return "walk_right"
		Dirs.UP:
			return "walk_up"
		Dirs.DOWN:
			return "walk_down"
	return direction
		
