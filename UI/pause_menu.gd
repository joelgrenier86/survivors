extends CanvasLayer
var main_scene = load("res://main.tscn")
var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		Events.toggle_pause.emit()
