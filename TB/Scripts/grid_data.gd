extends Node

# 2D Array containing GridTile

var grid_data = []
var grid_width = 10
var grid_height = 10


func _init_grid():
	for _x in grid_width:
		var column = []
		for _y in grid_height:
			column.append(GridTile.new(Vector2(_x, _y)))
		grid_data.append(column)

# Calculate Map Size
func _calculate_grid_size(map: Node2D) -> void:
	var level_bounds = map.get_node("LevelBounds/CollisionShape2D")
	grid_width = level_bounds.shape.size.x / 8
	grid_height = level_bounds.shape.size.y / 8
	print(get_tree().get_current_scene().name, "'s grid size is [", grid_width, ", ", grid_height, "]")

# Register collision
func register_collision(collision_name: String, collision_coords: Vector2, is_occupied: bool) -> void:
	grid_data[collision_coords.x][collision_coords.y].occupied = is_occupied
	grid_data[collision_coords.x][collision_coords.y].hit_array.append(collision_name)
	grid_data[collision_coords.x][collision_coords.y].coords = collision_coords

# Reset Map
func reset_grid() -> void:
	grid_data = []
	grid_width = 10
	grid_height = 10
	
# Debug Print Map
func debug_print_grid() -> void:
	var output = ""
	for y in range(grid_height):
		for x in range(grid_width):
			if grid_data[x][y].hit_array.has("Player"):
				output += "[O]"
			elif grid_data[x][y].occupied == true:
				output += "[X]"
			else:
				output += "[ ]"
		output+="\n"
	print(output)

# Debug Print Coords
func getValuesAsString(cellBeginString = "", cellEndString = "") -> void:
	var output = ""
	for y in range(grid_height):
		for x in range(grid_width):
			output += cellBeginString
			output += str(grid_data[x][y].coords)
			output += cellEndString
		output+="\n"
	print(output)

func reset_gridtile(gridtile_coords: Vector2):
	var gridtile = grid_data[gridtile_coords.x][gridtile_coords.y]
	gridtile.occupied = false
	gridtile.hit_array = []
	gridtile.coords = gridtile_coords

func leave_gridtile(gridtile_coords: Vector2, leaving_obj: String):
	var gridtile = grid_data[gridtile_coords.x][gridtile_coords.y]
	gridtile.occupied = false
	gridtile.hit_array.erase(leaving_obj)
	print("Removed ", leaving_obj, " from hit_array at ", gridtile_coords)
	
func coords_are_in_bounds(coords_to_check: Vector2) -> bool:
	if (coords_to_check.x >= 0 and coords_to_check.x <= grid_width - 1) and (coords_to_check.y >= 0 and coords_to_check.y <= grid_height - 1):
		return true
	return false

func load_map(map: Node2D) -> void:
	_calculate_grid_size(map)
	_init_grid()
