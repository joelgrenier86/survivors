extends CharacterBody2D
class_name Entity

var max_health : int = 100
var current_health : int = 100
var speed = 100
var attack_power = 1
var spell_power = 1
var health_regen = 0
var cooldowns = {}

func load_ability(ability_name):
	var scene
	if ability_name == "projectile" or ability_name == "attack":
		scene = load("res://Abilities/" +ability_name +  ".tscn")
	else:
		scene = load("res://Abilities/" + ability_name +"/" +ability_name +  ".tscn")
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

func take_damage(damage):
	current_health-= damage
	

