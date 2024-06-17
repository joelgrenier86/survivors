extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_health_component_is_dead():
	
	die()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_health_component_health_changed(current_health):
	pass # Replace with function body.
