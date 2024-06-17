extends Enemy



func _on_health_component_is_dead():
	roll_drops()
	die()
	
	



func _on_health_component_health_changed(new_health):
	current_health = new_health
