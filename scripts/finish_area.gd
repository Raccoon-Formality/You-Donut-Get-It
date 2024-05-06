extends Area3D



var counter = 0.0
func _process(delta):
	counter += delta
	$Node3D.rotation_degrees.y += delta * 100
	$Node3D.position.y = sin(counter) * 0.1


func _on_area_entered(area):
	if area.is_in_group("player"):
		$sound.play()
		var player = area.get_parent()
		player.pause()
		player.level_end_anim.play("new_animation")
		var number = get_parent().num
		if Global.times[number] > Global.time:
			Global.times[number] = Global.time
			Global.lives[number] = Global.deaths
		$Timer.start()


func _on_timer_timeout():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn")
