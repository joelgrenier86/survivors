extends Enemy



func _on_health_component_is_dead():
	Events.score_points.emit(point_value)
	queue_free()
	



func _on_health_component_health_changed(new_health):
	current_health = new_health
