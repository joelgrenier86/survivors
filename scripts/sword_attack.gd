extends Area2D
var angle = Vector2.ZERO
@export var damage = 1
@export var knockback = -2
@export var cooldown = 2
signal deal_damage
signal cooldown_ready


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_cooldown_timer_timeout():
	queue_free()
	
	
func execute(caster, target):
	if !target:
		target = Vector2.RIGHT
	angle = position.direction_to(target)
	
	rotation = angle.angle() + deg_to_rad(135)
	var final = rotation_degrees - 90
	var tween = Tween.new()
	tween.tween_property(self,"rotation_degrees", final, 1)
	
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.handle_hit(self)
	
func is_melee():
	return true
