extends CharacterBody2D
const sword = preload("res://sword_attack.tscn")
var attack_cd = 4
var speed = 200
var direction = Vector2.DOWN
var aimer
var attacking = false
var health = 100
var auto_attack = true
var auto_aim = true
var nearby = []
func _ready():
	pass

func _physics_process(delta):
	aimer = get_local_mouse_position()
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
	if Input.is_action_pressed("attack") && !auto_attack:
		
		if !attacking && nearby[0] != null:
			player_attack()
			attacking = true
			$AttackCD.start()

	if velocity.length() >0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	
	
func player_attack():

	
	var sword_attack = sword.instantiate()
	if auto_aim && nearby != []:
		##error when the array is empty

		
		var aimer2
		var closest =  get_closest_enemy_or_null(nearby)
		aimer2 = to_local(closest.position)
		print("aimer" + str(aimer))
		print("aimer2" + str(aimer2))
		sword_attack.target = aimer2
		
	else:
		sword_attack.target = aimer
	
		
	
	add_child(sword_attack)
	

func get_closest_enemy_or_null(nearby):
	var min_dist = 50000
	var nearest = null
	if nearby.size() >0:
		nearest = nearby[0]
		for enemy in nearby:
			
			var distance = global_position.distance_squared_to(enemy.global_position)
			var distance_nearest = global_position.distance_squared_to(nearest.global_position)
			if distance < distance_nearest:
				nearest = enemy

	
	return nearest
	

	
	
	




func _on_attack_cd_timeout():
	attacking = false 
	if auto_attack:
		player_attack()
func take_damage(amount):
	health -= amount
	print(health)
	if health <= 0:
		print("you died")








func _on_enemy_detector_body_entered(body):
	nearby.append(body)
	

func _on_enemy_detector_body_exited(body):
	for i in range(0,nearby.size()):
		if body == nearby[i]:
			nearby.remove_at(i)
			break
			
