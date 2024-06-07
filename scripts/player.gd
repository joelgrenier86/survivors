extends Entity
var attack_cd = 4 


var direction = Vector2.DOWN
var aimer = Vector2.ZERO
var attacking = false
 
var auto_attack = true
var auto_aim = true
var nearby = []
var ability_tracker = {}
func _ready():
	current_health =2
	speed = 200
	Events.cooldown_ready.connect(handle_cooldown)
	var proj = {"name" :"projectile", "ready": true }
	ability_tracker[1] = proj

func _physics_process(delta):
	
	cast_available_spells()
	handle_input()
	move_and_slide()
	check_collisions()
	



	
	

	pass

	



func handle_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		direction = Vector2.UP
		$PlayerAnimation.play("player_back_walk")
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
		$PlayerAnimation.play("player_front_walk")
		direction = Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
		$PlayerAnimation.play("player_left_walk")
		direction = Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
		$PlayerAnimation.play("player_right_walk")
		direction = Vector2.RIGHT
	if Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_left"):
		$PlayerAnimation.stop()
		if direction == Vector2.DOWN:
			$PlayerAnimation.play("player_front_idle")
		if direction == Vector2.UP:
			$PlayerAnimation.play("player_back_idle")
		if direction == Vector2.LEFT:
			$PlayerAnimation.play("player_left_idle")
		if direction == Vector2.RIGHT:
			$PlayerAnimation.play("player_right_idle")

	

	if velocity.length() >0:
		velocity = velocity.normalized() * speed
	
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
	

	
	


func cast_available_spells():
	for i in range(1, ability_tracker.size()+1):
	
		if ability_tracker[i]["ready"]:
			var new_ability = load_ability(ability_tracker[i]["name"])
			new_ability.execute(self, get_closest_enemy_or_mouse_position(), i)
			ability_tracker[i]["ready"] = false
	
		
	



func handle_cooldown(ability_name, ability_index):
	ability_tracker[ability_index]["ready"] = true

func _on_enemy_detector_body_entered(body):
	nearby.append(body)
	

func _on_enemy_detector_body_exited(body):
	for i in range(0,nearby.size()):
		if body == nearby[i]:
			nearby.remove_at(i)
			break
			


func _on_health_component_is_dead():
	print("youre dead")


func _on_health_component_health_changed(new_health):
	current_health = new_health
