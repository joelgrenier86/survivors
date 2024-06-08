extends Node2D
var velocity : Vector2
var direction : Vector2
enum Dirs {LEFT,RIGHT,UP,DOWN} 
var dir

enum State{WALKING, IDLE}
var state_machine = State.IDLE 
@export var player_animator : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	dir = Dirs.DOWN # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func get_direction():
	velocity=Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		dir = Dirs.UP
		state_machine = State.WALKING
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
		state_machine = State.WALKING
		dir = Dirs.DOWN
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
		state_machine = State.WALKING
		dir= Dirs.LEFT
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
		state_machine = State.WALKING
		dir = Dirs.RIGHT
	if Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_left"):
		state_machine = State.IDLE
	return velocity	
	
func get_animation_direction():
	var animation_name = ""
	if state_machine == State.WALKING:
		animation_name += "walk"
	else:
		animation_name += "idle"
	match dir:
		Dirs.DOWN:
			animation_name += "_down"
		Dirs.UP:
			animation_name += "_up"
		Dirs.LEFT:
			animation_name += "_left"
		Dirs.RIGHT:
			animation_name += "_right"
	return animation_name
