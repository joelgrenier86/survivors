extends Entity
class_name Enemy
var direction_finder
var movement_component
var animation_name
@export var xp_value = 2
@export var enemy_drop_modifier = 1
var collision_count
var collisions = []
var animator_component
@onready var loot_component
@onready var animation = $EnemyAnimation

##for basic enemy functionality, for now, they must have a collision box named EnemyCollisionBox
##components attached for movement, health,direction finding and animating.  These attach to
##the bat/skeleton/etc component and in the future i will make some/all optional. 
func _ready():
	animator_component = $AnimatorComponent
	direction_finder = $EnemyDirectionFinderComponent
	movement_component = $MovementComponent
	loot_component = $LootDropComponent
	if animator_component == null:
		print("AnimatorComponent is null")
	
	print("AnimatorComponent: ", animator_component)
	print("EnemyDirectionFinderComponent: ", direction_finder)
	print("MovementComponent: ", movement_component)
	print("LootDropComponent: ", loot_component)
	is_initialized = true
func _physics_process(_delta):
	#every update we want the enemy to find the player and move towards it, get the animation name and play the animation
	#for simplicity and learning purposes we are using only 4 movement direction animations even though theres diagonal movement

	move(movement_component)
	animate_entity( animator_component, direction_finder, animation)
func roll_drops():
	$LootDropComponent.drop_loot(xp_value, enemy_drop_modifier)
func die():

	queue_free()
