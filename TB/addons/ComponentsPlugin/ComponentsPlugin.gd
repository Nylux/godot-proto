@tool
extends EditorPlugin

 
func _enter_tree():
	add_custom_type("GridMovementComponent", "Node", preload("res://Components/grid_movement_component.gd"), preload("res://Art/Node.svg"))
	add_custom_type("PlayerInputComponent", "Node", preload("res://Components/player_input_component.gd"), preload("res://Art/Node.svg"))
	add_custom_type("HealthComponent", "Node", preload("res://Components/health_component.gd"), preload("res://Art/Node.svg"))
	add_custom_type("AttackComponent", "Node", preload("res://Components/attack_component.gd"), preload("res://Art/Node.svg"))
	add_custom_type("AiComponent", "Node", preload("res://Components/ai_component.gd"), preload("res://Art/Node.svg"))


func _exit_tree():
	remove_custom_type("GridMovementComponent")
