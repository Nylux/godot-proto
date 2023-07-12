extends Node
class_name AttackComponent

@export var damage: int = 20
@export var attack_range: int = 1

# TODO : Getters & Setters for damage / attack range

# Attack someone
func attack(target: Node2D) -> void:
	"""
	Attacks provided target.
	Target needs to have a HealthComponent and a GridMovementComponent.
	"""
	
	if !target:
		return
	
	if !is_in_range(target):
		print(get_parent().name, " can't attack ", target.name, ". (Out of range)")
		return
	
		
	if target.get_node("HealthComponent").get_health() <= 0:
		print(target.name, " is already dead.")
		return
		
	target.get_node("HealthComponent").receive_damage(damage)
	print(get_parent().name, " attacked ", target.name, " for ", str(damage), " damage !")
	
	if (target.get_node("HealthComponent").get_health() <= 0):
		if target.get_node("HealthComponent").organic == true:
			print(target.name, " died !")
		else:
			print(target.name, " broke !")
	else:
		print("It now has ", str(target.get_node("HealthComponent").get_health()), " health.")


# Check that target is within attack range
func is_in_range(target: Node2D) -> bool:
	var attacker_coords = get_parent().get_node("GridMovementComponent").get_coords()
	var target_coords = target.get_node("GridMovementComponent").get_coords()
	var distance = abs(max(attacker_coords.x, target_coords.x) - min(attacker_coords.x, target_coords.x)) + abs(max(attacker_coords.y, target_coords.y) - min(attacker_coords.y, target_coords.y))
	if distance == attack_range + 1:
		if abs(max(attacker_coords.x, target_coords.x) - min(attacker_coords.x, target_coords.x)) == attack_range and abs(max(attacker_coords.y, target_coords.y) - min(attacker_coords.y, target_coords.y)) == attack_range:
			return true
	if distance > attack_range:
		return false
	return true
