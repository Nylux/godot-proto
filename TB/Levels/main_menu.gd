extends Node2D

func _ready():
	get_node("ButtonLayout/NewGameButton").grab_focus()

func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_0.tscn")



func _on_quit_button_pressed():
	get_tree().quit()
