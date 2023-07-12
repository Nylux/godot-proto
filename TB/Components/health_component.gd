extends Node
class_name HealthComponent

@export var max_health:int = 100
@export var health:int = 100
@export var organic:bool = false


## --------------- GETTERS ---------------

# Get max health
func get_max_health() -> int:
	return max_health

# Get health
func get_health() -> int:
	return health


## --------------- SETTERS ---------------

# Set max health
func set_max_health(value: int) -> void:
	self.max_health = value

# Set health
func set_health(value: int) -> void:
	self.health = value


## --------------- MODIFIERS ---------------

# Add health
func add_health(amount: int) -> void:
	self.health += amount

# Remove health
func remove_health(amount: int) -> void:
	self.health -= amount


## ---------- METHODS ----------

# Get attacked
func receive_damage(dmg: int) -> void:
	if get_health() <= 0:
		return
	remove_health(dmg)
	if get_health() <= 0:
		set_health(0)
		_die()


# Check if health is > 0
func is_alive() -> bool:
	if get_health() > 0:
		return true
	return false


# Die
func _die() -> void:
	get_parent().queue_free()
	GridData.reset_gridtile(get_parent().get_node("GridMovementComponent").get_coords())
