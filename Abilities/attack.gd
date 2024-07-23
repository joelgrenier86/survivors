extends Area2D
class_name Attack
@export var cooldown = 2.0
@export var damage = 1
var ability_index
var angle = Vector2.ZERO
var ability_name = "attack"
var attack_node
var cooldown_reduction
signal deal_damage
signal cooldown_ready
var player_stats = []


func execute(caster, target, ability_slot, player_stats):
	var player_ap = 0
	var player_cdr = 0
	for stat in player_stats:
		match stat.name:
			"attack_power":
				player_ap = stat.value
			"cooldown_reduction":
				player_cdr = stat.value
	if typeof(target) != 5:
		target = target.global_position
	ability_index = ability_slot
	if !target:
		target = Vector2.RIGHT
	angle = position.direction_to(target)
	damage += player_ap
	cooldown_reduction = player_cdr
	attack_node.animate_attack()
	
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
func send_cooldown_signal():
	
	Events.cooldown_ready.emit(ability_name, ability_index)
	queue_free()
