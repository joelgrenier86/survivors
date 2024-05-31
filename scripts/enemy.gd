extends CharacterBody2D
#might have to change to characterbody to use move and slide?
@export var speed =50
var health = 2
var knockback = 1
var point_value = 1
enum Dirs {LEFT,RIGHT,UP,DOWN}
var dir = Dirs.DOWN


@onready var player = get_tree().get_first_node_in_group("player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	if direction.x < 0:
		dir = Dirs.LEFT
	elif direction.x > 0:
		dir = Dirs.RIGHT
	elif direction.y < 0:
		dir = Dirs.UP
	elif direction.y > 0:
		dir = Dirs.DOWN
	velocity = direction * (speed * knockback)
	
	move_and_slide()
	check_for_player_collision()
	
func check_for_player_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("player"):
			collider.take_damage(1)
		
func take_damage(damage, force, angle):
	health-=damage
	print(health)
	if health <= 0:
		Events.score_points.emit(point_value)
		queue_free()
	knockback = -2
	$KnockTimer.start()

func die():
	queue_free()

func _on_knock_timer_timeout():
	knockback = 1 
