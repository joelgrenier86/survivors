extends Area2D
class_name Attack
@export var cooldown = 2.0
@export var damage = 1
var ability_index
var angle = Vector2.ZERO
var ability_name = "attack"
var attack_node
signal deal_damage
signal cooldown_ready



func execute(caster, target, ability_slot):
	if typeof(target) != 5:
		target = target.global_position
	ability_index = ability_slot
	if !target:
		target = Vector2.RIGHT
	angle = position.direction_to(target)
	attack_node.animate_attack()
	
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
func send_cooldown_signal():
	print("cooldown ended")
	Events.cooldown_ready.emit(ability_name, ability_index)
	queue_free()
