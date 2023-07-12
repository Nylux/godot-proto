extends Node
class_name AiComponent

# Choose random direction (UP, DOWN, LEFT, RIGHT)
# Try to move in chosen direction 
# If not possible, choose another direction and try again
# If no possible direction is possible, do nothing

enum direction {UP, DOWN, LEFT, RIGHT}

func _ready():
	get_tree().get_current_scene().get_node("Player/PlayerInputComponent").next_turn.connect(roam)

func roam():
	var player_coords = get_tree().get_current_scene().get_node("Player/GridMovementComponent").get_coords()
	var coords = get_parent().get_node("GridMovementComponent").get_coords()
	var dir = randi_range(0, direction.size() - 1)
	match direction.find_key(dir):
		"UP":
			get_parent().get_node("GridMovementComponent").add_coords(Vector2(0, -1))
			print(get_parent().name, " moved UP")
		"DOWN":
			get_parent().get_node("GridMovementComponent").add_coords(Vector2(0, 1))
			print(get_parent().name, " moved DOWN")
		"LEFT":
			get_parent().get_node("GridMovementComponent").add_coords(Vector2(-1, 0))
			print(get_parent().name, " moved LEFT")
		"RIGHT":
			get_parent().get_node("GridMovementComponent").add_coords(Vector2(1, 0))
			print(get_parent().name, " moved RIGHT")
