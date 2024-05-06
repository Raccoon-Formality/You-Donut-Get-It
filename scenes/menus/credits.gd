extends Control


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn")


func _on_button_pressed():
	OS.shell_open("https://raccoon-formality.itch.io/") 


func _on_button_2_pressed():
	OS.shell_open("https://raccoonformality.com/") 
