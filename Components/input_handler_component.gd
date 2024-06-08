extends Node2D
var velocity : Vector2
var direction : Vector2
enum Dirs {LEFT,RIGHT,UP,DOWN} 
var dir
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
		direction = Vector2.UP
		player_animator.play("player_back_walk")
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
		player_animator.play("player_front_walk")
		direction = Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
		player_animator.play("player_left_walk")
		direction = Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
		player_animator.play("player_right_walk")
		direction = Vector2.RIGHT
	if Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_left"):
		player_animator.stop()
		if direction == Vector2.DOWN:
			dir = Dirs.DOWN
		if direction == Vector2.UP:
			dir = Dirs.UP
		if direction == Vector2.LEFT:
			dir = Dirs.LEFT
		if direction == Vector2.RIGHT:
			dir = Dirs.RIGHT
	return velocity	
	
func get_animation_direction():
	match dir:
		Dirs.DOWN:
			return "walk_down"
		Dirs.UP:
			return "walk_up"
		Dirs.LEFT:
			return "walk_left"
		Dirs.RIGHT:
			return "walk_right"
