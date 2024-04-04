extends Area3D




func _process(delta):
	$Node3D.rotation_degrees.y += delta * 100


func _on_area_entered(area):
	if area.is_in_group("player"):
		$sound.play()
		var player = area.get_parent()
		player.pause()
		$Timer.start()


func _on_timer_timeout():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
