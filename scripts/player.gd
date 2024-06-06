extends Entity
@onready var ability_handler = $AbilityCatalogComponent
var attack_cd = 4 


var direction = Vector2.DOWN
var aimer = Vector2.ZERO
var attacking = false
var health = 100
var auto_attack = true
var auto_aim = true
var nearby = []
var ability_tracker = {}
func _ready():
	speed = 200
	Events.cooldown_ready.connect(handle_cooldown)
	var proj = {"name" :"projectile", "ready": true }
	ability_tracker[1] = proj
	# Events.melee_attack_ready.connect(prepare_melee_attack)
	# Events.projectile_ready.connect(prepare_projectile)
	# Events.add_ability.connect(add_new_ability)
	# ability_handler.add_new_ability("sword_attack")
	
	#for ability in current_abilities:
		#if ability.has_method("_on_cooldown_timer_timeout"):
			#ability._on_cooldown_timer_timeout.connect(use_ability(ability))
func _physics_process(delta):
	aimer = get_local_mouse_position()
	velocity = Vector2.ZERO
	for i in range(1, ability_tracker.size()+1):
		print(ability_tracker[i]["ready"])
		if ability_tracker[i]["ready"]:
			var new_ability = load_ability(ability_tracker[i]["name"])
			new_ability.execute(self, get_closest_enemy_or_mouse_position(), i)
			ability_tracker[i]["ready"] = false
	
		
	
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
	#if Input.is_action_pressed("attack"):
		#var projectile = load_ability("projectile")
		#projectile.execute(self, get_closest_enemy_or_mouse_position())
	

	if velocity.length() >0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	
	

	pass
	#var ability = ability_to_use.instantiate()
	#if ability.has_method("is_melee"):
		#if auto_aim && nearby != []:
			#var aimer2
			#var closest =  get_closest_enemy_or_null(nearby)
			#aimer2 = to_local(closest.position)
			#print("aimer" + str(aimer))
			#print("aimer2" + str(aimer2))
			#ability.target = aimer2	
		#else:
			#ability.target = aimer
	#add_child(ability)
	
#create a function that takes a skill name as an input, creates the skill instance and executes it AND 
#starts a cooldown timer for the skills that it retrieves from skill.cooldown




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
	

	
	
func prepare_melee_attack():
	var target 
	if nearby != []:
		target = to_local(get_closest_enemy_or_mouse_position())
		print("auto")
	else:
		target = aimer
		print("mouse")
	$AbilityCatalogComponent.set_melee_target(to_local(target))

func prepare_projectile():
	var target 
	if nearby != []:
		target = to_local(get_closest_enemy_or_mouse_position().position)
		print("auto")
	else:
		target = aimer
		print("mouse")
	$AbilityCatalogComponent.set_melee_target(to_local(target))



func _on_attack_cd_timeout():
	pass
	#attacking = false 
	#if auto_attack:
		#player_attack()
func take_damage(amount):
	health -= amount
	print(health)
	if health <= 0:
		print("you died")
func handle_cooldown(ability_name, ability_index):
	ability_tracker[ability_index]["ready"] = true

func _on_enemy_detector_body_entered(body):
	nearby.append(body)
	

func _on_enemy_detector_body_exited(body):
	for i in range(0,nearby.size()):
		if body == nearby[i]:
			nearby.remove_at(i)
			break
			
