extends CharacterBody2D
class_name Entity

@export var max_health : int = 100
var current_health : int = 100
@export var speed = 100
var attack_power = 1
var spell_power = 1
var health_regen = 0
var cooldowns = {}
var knockback = 1




func load_ability(ability_name):
	var scene
	if ability_name == "sword_attack":
		scene = load("res://Abilities/Attack/" +ability_name +"/" +ability_name +  ".tscn")
	else:
		scene = load("res://Abilities/Spell/" + ability_name +"/" +ability_name +  ".tscn")
	var scene_node = scene.instantiate()
	add_child(scene_node)

	return scene_node

func start_cooldown(ability, cooldown):
	#add key value ability : cooldown to dictionary cooldowns
	cooldowns[ability] = cooldown

func _physics_process(delta):
	if current_health <= 0:
		queue_free()    
	if health_regen > 0:
		regen_health(delta)

func regen_health(delta):
	current_health += health_regen * delta
	if current_health > max_health:
		current_health = max_health
func move(movement_component):
	velocity = movement_component.get_velocity(speed) * knockback 
	move_and_slide()
func check_collisions():	
	var collisions = get_slide_collision_count()
	for i in collisions:
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("enemies") && is_in_group("player"):				
				take_damage(1)
func take_damage(damage):
	
	$HurtboxComponent.handle_hit(damage)
	if is_in_group("enemies"):
		var knock_timer = Timer.new()
		knock_timer.wait_time = 0.2
		add_child(knock_timer)
		knock_timer.connect("timeout", _on_knock_timer_timeout)
		knock_timer.start()
		knockback = -2
		
		

func animate_entity(animator_component,direction_finder, animation):
	var animation_name = direction_finder.get_animation_direction()
	animation.play(animation_name)
	
		
func _on_knock_timer_timeout():
	knockback = 1
	

