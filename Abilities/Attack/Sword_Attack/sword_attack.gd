extends Attack


@export var knockback = -2


# Called when the node enters the scene tree for the first time.
func _ready():
	ability_name = "sword_attack"
	attack_node = self



# Called every frame. 'delta' is the elapsed time since the previous frame.
func animate_attack():
	rotation = angle.angle() + deg_to_rad(135)
	var final = rotation_degrees - 359
	var tween = get_tree().create_tween()
	tween.tween_property(self,"rotation_degrees", final, 0.75)
	tween.connect("finished", on_tween_finished)

func _on_cooldown_timer_timeout():
	send_cooldown_signal()

func on_tween_finished():
	visible = false
	
	

	
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(1)
	
func is_melee():
	return true
