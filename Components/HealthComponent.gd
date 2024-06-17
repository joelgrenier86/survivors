extends Node2D
var max_health 
var current_health
signal is_dead
signal health_changed(current_health)
# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = get_parent().max_health
	current_health = max_health
	

func heal_damage(heal):
	current_health += heal
	
	if current_health > max_health:
		current_health = max_health
	
func _on_hurtbox_component_change_health(damage):

	current_health -= damage
	print (current_health)
	if current_health <= 0:
		is_dead.emit()
	else:
		health_changed.emit(current_health)
