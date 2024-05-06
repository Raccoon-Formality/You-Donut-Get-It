extends RigidBody3D

var power = 0.5 * 4.0
var mouse_sensitivity = 0.004
var start_pos
var mouse_limit = 100.0
var ended = false

@onready var time_label = $CanvasLayer/Control/Time
@onready var deaths_label = $CanvasLayer/Control/Deaths
@onready var camera_rig = get_tree().get_nodes_in_group("camera_rig")[0]
@onready var pause_menu_anim = $CanvasLayer/pause_menu/pause_anim
@onready var level_end_anim = $CanvasLayer/level_end_screen/AnimationPlayer
var marker = preload("res://scenes/marker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	ended = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	start_pos = global_position

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var mouse_vec = event.relative
		if Input.is_action_pressed("CLICK"):
			camera_rig.rotation.y -= mouse_vec.x * mouse_sensitivity
			camera_rig.rotation.z -= mouse_vec.y * mouse_sensitivity
			camera_rig.rotation_degrees.z = clamp(camera_rig.rotation_degrees.z, -90.0, 90.0)
		else:
			mouse_vec = mouse_vec.rotated(-camera_rig.rotation.y)
			mouse_vec.x = clamp(mouse_vec.x, -mouse_limit, mouse_limit)
			mouse_vec.y = clamp(mouse_vec.y, -mouse_limit, mouse_limit)
			apply_torque_impulse(Vector3(mouse_vec.x * mouse_sensitivity * power * 100.0 * Global.sensitivity,0,0))
			apply_torque_impulse(Vector3(0, 0, mouse_vec.y * mouse_sensitivity * power * 100.0 * Global.sensitivity))
			#$Position3D.rotation_degrees.x = clamp($Position3D.rotation_degrees.x, -90, 90)
		
	if event is InputEventKey and event.keycode == 32 and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventKey and event.keycode == KEY_TAB and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu_anim.play("show")
		pause()
	if event is InputEventJoypadButton and event.button_index == JOY_BUTTON_START and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu_anim.play("show")
		pause()
	
	if Input.is_action_pressed("MENU"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu_anim.play("show")
		pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.y < -10:
		die()
	Global.time += delta
	if Global.time < 60.0:
		time_label.text = str(snapped(Global.time, 0.01))
	else:
		var seconds = snapped(fmod(Global.time,60.0), 0.01)
		if seconds < 10.0:
			time_label.text = str(floor(Global.time/60)) + ":0" + str(seconds)
		else:
			time_label.text = str(floor(Global.time/60)) + ":" + str(seconds)
	
	var controller_vec = Vector2.ZERO
	controller_vec.y = (Input.get_action_strength("CONTROL_UP") - Input.get_action_strength("CONTROL_DOWN")) * -10
	controller_vec.x = (Input.get_action_strength("CONTROL_RIGHT") - Input.get_action_strength("CONTROL_LEFT")) * 10
	if Input.is_action_pressed("CLICK"):
		camera_rig.rotation.y -= controller_vec.x / 2 * mouse_sensitivity
		camera_rig.rotation.z -= controller_vec.y / 2 * mouse_sensitivity
		camera_rig.rotation_degrees.z = clamp(camera_rig.rotation_degrees.z, -90.0, 90.0)
	else:
		controller_vec = controller_vec.rotated(-camera_rig.rotation.y)
		controller_vec.x = clamp(controller_vec.x, -mouse_limit, mouse_limit)
		controller_vec.y = clamp(controller_vec.y, -mouse_limit, mouse_limit)
		apply_torque_impulse(Vector3(controller_vec.x * mouse_sensitivity * power * 100.0 * Global.sensitivity,0,0))
		apply_torque_impulse(Vector3(0, 0, controller_vec.y * mouse_sensitivity * power * 100.0 * Global.sensitivity))
		#$Position3D.rotation_degrees.x = clamp($Position3D.rotation_degrees.x, -90, 90)
	
	var camera_vec = Vector2.ZERO
	camera_vec.y = (Input.get_action_strength("CAM_UP") - Input.get_action_strength("CAM_DOWN")) * -7
	camera_vec.x = (Input.get_action_strength("CAM_RIGHT") - Input.get_action_strength("CAM_LEFT")) * 7
	camera_rig.rotation.y -= camera_vec.x / 2 * mouse_sensitivity
	camera_rig.rotation.z -= camera_vec.y / 2 * mouse_sensitivity
	camera_rig.rotation_degrees.z = clamp(camera_rig.rotation_degrees.z, -90.0, 90.0)
	
	if Input.is_action_just_pressed("RESET"):
		die()
	
var local_collision_pos
func _integrate_forces( state ):
	if(state.get_contact_count() >= 1):
		local_collision_pos = state.get_contact_local_position(0)

func _on_body_entered(body):
	#print(angular_velocity.length())
	if angular_velocity.length() > 5.0 and linear_velocity.length() > 2.0:
		var collision_position = local_collision_pos
		var marker_instance = marker.instantiate()
		marker_instance.position = collision_position
		get_tree().root.add_child(marker_instance)
		marker_instance.emitting = true
	if angular_velocity.length() > 5.0 and linear_velocity.length() > 2.0:
		$thunk.pitch_scale = randf_range(1.0,2.0)
		$thunk.play()
	if angular_velocity.length() > 10.0 and linear_velocity.length() > 4.0:
		$bonk.pitch_scale = randf_range(1.0,2.0)
		$bonk.play()

var save_vel
var save_ang_vel

func die():
	global_position = start_pos
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	rotation = Vector3.ZERO
	Global.deaths += 1
	if Global.deaths == 7:
		$suck.play()
	else:
		$tryagain.play()
	deaths_label.text = str(Global.deaths)

func pause():
	freeze = true
	save_vel = linear_velocity
	save_ang_vel = angular_velocity
	set_process_input(false)
	set_process(false)

func unpause():
	freeze = false
	linear_velocity = save_vel
	angular_velocity = save_ang_vel
	set_process_input(true)
	set_process(true)



func _on_player_area_area_entered(area):
	if area.is_in_group("death"):
		die()
