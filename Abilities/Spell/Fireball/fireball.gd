extends ProjectileBase


# Called when the node enters the scene tree for the first time.
func _ready():
	ability_name = "fireball"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cooldown_timer_timeout():
	send_cooldown_signal() # Replace with function body.
