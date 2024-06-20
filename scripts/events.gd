extends Node
signal give_xp(xp_value)
signal deliver_hit(damage)
signal add_ability(ability)
signal projectile_ready()
signal melee_attack_ready()
signal cooldown_ready(ability_name, ability_index)
signal set_max_xp(max_xp,current_xp)
signal update_xp_bar(current_xp)
signal toggle_pause()
signal player_level_up(max_xp, current_xp, level)


