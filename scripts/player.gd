extends Entity
 


var direction = Vector2.DOWN
var aimer = Vector2.ZERO
var level = 1
 
var auto_attack = true
var auto_aim = true
var nearby = []
var ability_tracker = {}
var current_xp = 0
var max_xp = 5
@onready var movement_component = $MovementComponent
@onready var direction_finder = $InputHandlerComponent
@onready var animator_component = $AnimatorComponent
@onready var animation = $PlayerAnimation

func _ready():
	
	
	Events.cooldown_ready.connect(handle_cooldown)
	Events.give_xp.connect(gain_xp)
	Events.set_max_xp.emit(max_xp,level)
	
	var sword_attack = {"name" : "sword_attack", "ready":true}
	
	ability_tracker[0] = sword_attack

func _physics_process(delta):
	
	cast_available_spells()
	move(movement_component)
	animate_entity(animator_component,direction_finder, animation)
	check_collisions()




func get_closest_enemy_or_mouse_position():

	var nearest = get_local_mouse_position()
	if nearby.size() >0:
		nearest = nearby[0]
		for enemy in nearby:
			
			var distance = global_position.distance_squared_to(enemy.global_position)
			var distance_nearest = global_position.distance_squared_to(nearest.global_position)
			if distance < distance_nearest:
				nearest = enemy

	
	return nearest
	

	
func add_ability(ability_name):
		ability_tracker[ability_tracker.size()] = {"name" :"fireball", "ready" : true}


func cast_available_spells():
	for i in range(0, ability_tracker.size()):
	
		if ability_tracker[i]["ready"]:
			var new_ability = load_ability(ability_tracker[i]["name"])
			new_ability.execute(self, get_closest_enemy_or_mouse_position(), i)
			ability_tracker[i]["ready"] = false
	
		
	



func handle_cooldown(ability_name, ability_index):
	ability_tracker[ability_index]["ready"] = true

func gain_xp(xp):
	current_xp += xp
	if current_xp >= max_xp:
		level_up()
	
	Events.update_xp_bar.emit(current_xp)

func level_up():
	current_xp -= max_xp
	max_xp = ceil(max_xp * 1.2)
	level +=1
	print ("level " + str(level))
	Events.set_max_xp.emit(max_xp, level)
	Events.update_xp_bar.emit(current_xp)
	
func _on_health_component_is_dead():
	print("youre dead")


func _on_health_component_health_changed(new_health):
	current_health = new_health
	
func _on_enemy_detector_body_entered(body):
	nearby.append(body)
	

func _on_enemy_detector_body_exited(body):
	for i in range(0,nearby.size()):
		if body == nearby[i]:
			nearby.remove_at(i)
			break
