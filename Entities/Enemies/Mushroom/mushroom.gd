extends Enemy

func _ready():
	pass
func _on_health_component_is_dead():
	
	die()


func _on_health_component_health_changed(current_health):
	pass # Replace with function body.
