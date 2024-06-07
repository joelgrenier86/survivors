extends Entity
class_name Enemy
var direction
var animation_name
@export var point_value = 2
var collision_count
var collisions = []
##for basic enemy functionality, for now, they must have a collision box named EnemyCollisionBox
##components attached for movement, health,direction finding and animating.  These attach to
##the bat/skeleton/etc component and in the future i will make some/all optional. 

func _physics_process(_delta):
	#every update we want the enemy to find the player and move towards it, get the animation name and play the animation
	#for simplicity and learning purposes we are using only 4 movement direction animations even though theres diagonal movement

	direction = $EnemyDirectionFinderComponent.acquire_target_position()
	speed = $MovementComponent.get_movement_speed()
	velocity = speed * direction
	animation_name = $AnimatorComponent.get_enemy_animation()
	$EnemyAnimation.play(animation_name)
	move_and_slide()
func die():
	queue_free()
