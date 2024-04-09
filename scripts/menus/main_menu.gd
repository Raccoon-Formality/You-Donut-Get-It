extends Control

@onready var prop_donut = $background/Mesh

@onready var title = $CanvasLayer/Control/Youdonutgetit #$CanvasLayer/Control/title
@onready var subtitle = $CanvasLayer/Control/subtitle2 #$CanvasLayer/Control/subtitle
@onready var settings = $CanvasLayer/Control/settings
@onready var floorMaterial = $background/MeshInstance3D.mesh.material

@onready var donutLogo = $CanvasLayer/Control/Youdonutgetit

#var floor_speed = 1.0
var counter = 0.0

func _process(delta):
	prop_donut.rotation_degrees.z -= delta * 250.0 * Global.sensitivity
	counter += delta
	donutLogo.rotation_degrees = sin(counter) * 5
	donutLogo.scale.x = abs(cos(counter) * 0.01) + 0.09
	donutLogo.scale.y = abs(cos(counter) * 0.01) + 0.09
	#if floor_speed != Global.sensitivity:
	#	floor_speed = Global.sensitivity
	#	floorMaterial.set("shader_parameter/speed", Global.sensitivity)

var started = false

func _on_start_button_pressed():
	if !started:
		$AnimationPlayer.play("start")
		started = true


func _on_settings_button_pressed():
	if !started:
		title.visible = !title.visible
		subtitle.visible = !subtitle.visible
		settings.visible = !settings.visible
	


func _on_exit_button_pressed():
	if !started:
		get_tree().quit()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "start":
		get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn")
