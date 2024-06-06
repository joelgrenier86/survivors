extends CharacterBody2D
var direction
var animation_name
@export var point_value = 2
var collision_count
var collisions = []
var speed
func _physics_process(_delta):
	#every update we want the enemy to find the player and move towards it, get the animation name and play the animation
	#for simplicity and learning purposes we are using only 4 movement direction animations even though theres diagonal movement

	direction = $EnemyDirectionFinderComponent.acquire_target_position()
	speed = $MovementComponent.get_movement_speed()
	velocity = speed * direction
	animation_name = $AnimatorComponent.get_enemy_animation()
	$EnemyAnimation.play(animation_name)
	move_and_slide()
	
func _on_health_component_is_dead():
	Events.score_points.emit(point_value)
	queue_free()
func take_damage(damage):
	$HurtboxComponent.handle_hit(damage)


func _on_health_component_health_changed(current_health):
	pass # Replace with function body.
