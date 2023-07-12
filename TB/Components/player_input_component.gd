extends Node

#TODO: REFACTORING PLEASE GOD PLEASE USE SWITCH STATEMENT

signal next_turn

func _input(event):
	var grid_movement_comp = get_node("../GridMovementComponent")
	if (event.is_action_pressed("Up")):
		grid_movement_comp.add_coords(Vector2(0, -1))
		next_turn.emit()
		
	elif (event.is_action_pressed("Down")):
		grid_movement_comp.add_coords(Vector2(0, 1))
		next_turn.emit()
		
	elif (event.is_action_pressed("Left")):
		grid_movement_comp.add_coords(Vector2(-1, 0))
		next_turn.emit()
		
	elif (event.is_action_pressed("Right")):
		grid_movement_comp.add_coords(Vector2(1, 0))
		next_turn.emit()
		
	elif (event.is_action_pressed("Attack")):
		var origin = get_tree().get_current_scene().get_node("LevelBounds/Origin")
		var click_location = ((get_parent().get_global_mouse_position() - origin.global_position) / 8)
		click_location = Vector2(int(click_location.x), int(click_location.y))
		
		if !GridData.coords_are_in_bounds(click_location):
			return
			
		var target = []
		if GridData.grid_data[click_location.x][click_location.y].hit_array.is_empty() == false:
			target = GridData.grid_data[click_location.x][click_location.y].hit_array[0]
			
		if !target.is_empty():
			get_parent().get_node("AttackComponent").attack(get_tree().get_current_scene().get_node(target))
			next_turn.emit()
		else:
			print("Nothing to attack at coordinates ", click_location)
