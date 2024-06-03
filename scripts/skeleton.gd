extends CharacterBody2D
var direction
var animation_name
var collision_count
var collisions = []
var speed
@export var point_value = 1
func _physics_process(_delta):
	
	direction = $EnemyDirectionFinderComponent.acquire_target_position()
	speed = $MovementComponent.get_movement_speed()
	velocity = speed * direction
	animation_name = $AnimatorComponent.get_enemy_animation()
	$EnemyAnimation.play(animation_name)
	move_and_slide()
	
func _on_health_component_is_dead():
	Events.score_points.emit(point_value)
	queue_free()
	
func handle_hit(damage):
	$HurtboxComponent.handle_hit(damage)


func _on_health_component_health_changed(current_health):
	pass # Replace with function body.
