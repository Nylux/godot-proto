extends CharacterBody2D

func _ready():
	get_parent().ready.connect(deploy)
	
func deploy():
	var origin = get_tree().get_current_scene().get_node("LevelBounds/Origin")
	var coord = (self.global_position - origin.global_position) / 8
	
	coord = Vector2(int(coord.x), int(coord.y))
	print("Enemy coords: ", coord, "\n")
	GridData.register_collision(name, coord)
	GridData.debug_print_grid()
