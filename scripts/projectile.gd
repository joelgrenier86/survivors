extends CharacterBody2D
class_name Projectile
var ability_name = "projectile"
var angle = Vector2.ZERO
@export var speed = 500
@export var damage = 1
@export var knockback = -2
@export var cooldown = 2.0
signal deal_damage
signal cooldown_ready
var selfer = self
var ability_index
var collided = false


# Called when the node enters the scene tree for the first time.
	
func _physics_process(delta):
	print(angle)
	move_and_slide()
	if collided==false:		
		check_collisions()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func check_collisions():
	var collisions = get_slide_collision_count()
	if collisions != 0:
		collided = true
	for i in collisions:
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("enemies"):
				visible = false
				position = Vector2(-99, -99)
				collider.take_damage(1)
				break

	
	
func execute(caster, target, ability_slot):
	ability_index = ability_slot
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
	angle = direction.normalized()
	rotation = angle.angle() 
	velocity = speed * angle
	$SpellAnimation.play("ability_basic")
	

	
	


	
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.handle_hit(self)

	
func is_projectile():
	return true






func send_cooldown_signal():
	print("cooldown ended")
	Events.cooldown_ready.emit(ability_name, ability_index)
	queue_free()
