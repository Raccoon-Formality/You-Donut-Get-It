extends Control


func _ready():
	$Label3.text = ""
	for i in range(Global.times.size() - 1):
		$Label3.text += "Level " + str(i+1) + ": " + num_to_time(Global.times[i+1])+ " ("+str(Global.lives[i+1])+" attempts)" + "\n" 

func _on_button_pressed():
	ready_level()
	get_tree().change_scene_to_file("res://scenes/levels/World.tscn")


func _on_button_2_pressed():
	ready_level()
	get_tree().change_scene_to_file("res://scenes/levels/Level2/World.tscn")


func _on_button_3_pressed():
	ready_level()
	get_tree().change_scene_to_file("res://scenes/levels/Level3/World.tscn")


func _on_button_4_pressed():
	ready_level()
	get_tree().change_scene_to_file("res://scenes/levels/Level4/World.tscn")

func ready_level():
	Global.time = 0.00
	Global.deaths = 1
	$loading.show()


func _on_button_5_pressed():
	ready_level()
	get_tree().change_scene_to_file("res://scenes/levels/Level5/World.tscn")

func _on_button_6_pressed():
	ready_level()
	get_tree().change_scene_to_file("res://scenes/levels/Level6/World.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	

func num_to_time(num):
	var time
	if num < 60.0:
		time = str(snapped(num, 0.01))
	else:
		var seconds = snapped(fmod(num,60.0), 0.01)
		if seconds < 10.0:
			time = str(floor(num/60)) + ":0" + str(seconds)
		else:
			time = str(floor(num/60)) + ":" + str(seconds)
	return time


func _on_scores_button_pressed():
	if $scores_button.text == "show scores":
		$Label3.show()
		$scores_button.text = "hide scores"
	elif $scores_button.text == "hide scores":
		$Label3.hide()
		$scores_button.text = "show scores"


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")
