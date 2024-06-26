extends Enemy


func _on_health_component_is_dead():
	roll_drops()
	die()


func _on_health_component_health_changed(current_health):
	pass # Replace with function body.
