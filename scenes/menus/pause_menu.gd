extends Control



func _on_unpause_button_pressed():
	$pause_anim.play("hide")
	get_parent().get_parent().unpause()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
