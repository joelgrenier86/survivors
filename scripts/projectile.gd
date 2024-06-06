extends CharacterBody2D
var ability_name = "projectile"
var angle = Vector2.ZERO
var speed = 500
@export var damage = 1
@export var knockback = -2
@export var cooldown = 2.0
signal deal_damage
signal cooldown_ready
var selfer = self
var ability_index


# Called when the node enters the scene tree for the first time.
	
func _physics_process(delta):
	move_and_slide()
	check_collisions()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func check_collisions():
	var collisions = get_slide_collision_count()
	for i in collisions:
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("enemies"):
			collider.take_damage(1)

	
	
func execute(caster, target, ability_slot):
	ability_index = 1
	var root = caster.get_parent()
	caster.remove_child(self)
	root.add_child(self)
	global_position = caster.global_position
	
	visible = true
	var direction
	#have the projectile begin at the caster's position and move in straight			 line towards the target until it leaves the screen or collides with something
	if typeof(target) == 5:
		direction = get_global_mouse_position() - caster.global_position
	else:
		direction = target.global_position - caster.global_position
	direction = direction.normalized()
	angle = direction
	velocity = speed * direction
	
	var timer = Timer.new()  # Create a new Timer
	add_child(timer)  # Add the Timer to the current node
	#timer.wait_time = 1.0  # Set the Timer's wait time to 1 second
	#timer.one_shot = true  # Set the Timer to stop after finishing
	#timer.connect("timeout",selfer, "_on_cooldown_timer_timeout")  # Connect the Timer's timeout signal to the function
	#timer.start()  # Start the Timer
	#print("cooldown started?")

	
	


	
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.handle_hit(self)
	
func is_projectile():
	return true






func _on_cooldown_timer_timeout():
	print("cooldown ended")
	Events.cooldown_ready.emit(ability_name, ability_index)
	queue_free()
