extends Area2D
var target =Vector2.ZERO
var angle = Vector2.ZERO
@export var damage = 1
@export var knockback = -2
signal deal_damage


# Called when the node enters the scene tree for the first time.
func _ready():
	print(target)
	angle = position.direction_to(target)
	
	rotation = angle.angle() + deg_to_rad(135)
	var final = rotation_degrees - 90
	var tween = create_tween()
	tween.tween_property(self,"rotation_degrees", final, 0.15)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_attack_timer_timeout():
	queue_free()
	


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.handle_hit(self)
	
