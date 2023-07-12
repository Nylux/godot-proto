extends Node
class_name GridMovementComponent

"""
GridMovementComponent
--------------------------------------------------------------------------------
This component is responsible for moving, or being moved on the level's grid.
Any object requiring the ability to move on the grid, or teleport need this.
--------------------------------------------------------------------------------
It also handles collisions with other objects on the grid.
Any object requiring collisions needs this.
--------------------------------------------------------------------------------
Requires parent object to be located inside a Node2D (a level) with a 
LevelBounds properly set up.
"""

var parent
var obj_coords
var origin
@export var has_collisions: bool = true

func _ready():
	origin = get_tree().get_current_scene().get_node("LevelBounds/Origin")
	parent = get_parent()
	obj_coords = _calculate_coords()
	get_tree().get_current_scene().ready.connect(_register_coords)
	if !(parent is Node2D):
		print_debug("GridMovementComponent has wrong parent (" + str(parent) + ")")
	print(get_parent().name,  " registered at ", obj_coords)


## ---------- PRIVATE METHODS ----------

# Calculate object coords
func _calculate_coords() -> Vector2:
	"""
	Calculates coordinates on the grid from global position in godot.
	"""
	var coords =  (parent.global_position - origin.global_position) / 8
	return (Vector2(int(coords.x), int(coords.y)))

# Registers collisions in grid
func _register_coords() -> void:
	"""
	Adds collision in the grid at parent object's coordinates.
	"""
	GridData.register_collision(parent.name, obj_coords, has_collisions)


## ---------- GETTERS / SETTERS / MODIFIERS ----------

# Get coords
func get_coords() -> Vector2:
	"""
	Returns the parent's current grid coordinates.
	"""
	return obj_coords

# Set coords
func set_coords(target_coords: Vector2) -> void:
	"""
	Sets parent object's grid coordinates and move it to appropriate tile
	in the level if target destination is valid and unoccupied.
	"""
	if !(GridData.coords_are_in_bounds(target_coords)):
		print_debug("Coordinates are out of bounds for ", parent.name)
		print("Target coordinates : ", target_coords)
		print("Level Bounds : [", GridData.grid_width, ", ", GridData.grid_height, "]")
		return
	if (GridData.grid_data[target_coords.x][target_coords.y].occupied):
		print_debug(parent.name, " tried to move in an occupied tile")
		print("Target coordinates are already occupied by ", GridData.grid_data[target_coords.x][target_coords.y].hit_array)
		return
	var old_coords = obj_coords
	obj_coords = target_coords
	parent.global_position = Vector2(obj_coords.x * 8 + origin.global_position.x + 4, obj_coords.y * 8 + origin.global_position.y + 4)
	GridData.leave_gridtile(old_coords, parent.name)
	#GridData.leave_gridtile(obj_coords, parent.name)
	GridData.register_collision(parent.name, obj_coords, has_collisions)
	print("Moved ", parent.name, " to ", obj_coords)

# Add coords
func add_coords(coords_to_add: Vector2) -> void:
	"""
	Adds coordinates to parent object's current coordinates if target 
	destination is valid and unoccupied.
	"""
	var destination: Vector2 = obj_coords + coords_to_add
	if !GridData.coords_are_in_bounds(destination):
		print_debug("Coordinates are out of bounds for ", parent.name)
		print("Target coordinates : ", destination)
		print("Level Bounds : [", GridData.grid_width, ", ", GridData.grid_height, "]")
		return
	if (GridData.grid_data[destination.x][destination.y].occupied):
		print_debug(parent.name, " tried to move in an occupied tile")
		print("Target coordinates are already occupied by ", GridData.grid_data[destination.x][destination.y].hit_array)
		return
	var old_coords = obj_coords
	obj_coords = destination
	parent.global_position = Vector2(obj_coords.x * 8 + origin.global_position.x + 4, obj_coords.y * 8 + origin.global_position.y + 4)
	GridData.leave_gridtile(old_coords, parent.name)
	#GridData.leave_gridtile(obj_coords, parent)
	GridData.register_collision(parent.name, obj_coords, has_collisions)
	print("Moved ", parent.name, " to ", obj_coords)
