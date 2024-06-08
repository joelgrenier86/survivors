extends Node2D
enum Dirs {LEFT,RIGHT,UP,DOWN}
@export  var direction_component : Node2D
@export var knock_timer : Timer

var dir = Dirs.DOWN
@export var speed = 100
var knockback = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction_component and direction_component.has_method("get_direction"):
		var direc = direction_component.call("get_direction")
		print(direc)
	else:
		print("direction_component is not set or does not have get_direction method")

func get_velocity(speed):
	var velocity = direction_component.get_direction() * speed
	return velocity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func prepare_movement():
	return get_movement_direction()
func get_movement_direction():
	return direction_component.get_direction()
func get_movement_speed():
	return speed * knockback

func _on_hurtbox_component_knock_back():
	knockback = -2
	knock_timer.start()
	 # Replace with function body.


func _on_knock_timer_timeout():
	knockback = 1
