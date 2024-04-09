extends Node3D

@onready var player = get_parent().get_node("Player")
@onready var raycast = $RayCast3D
@onready var camera = $Camera3D
@onready var defaultPos = $Camera3D.position

func _process(_delta):
	global_position = lerp(global_position, player.global_position, 0.2)
	if raycast.is_colliding():
		camera.global_position = raycast.get_collision_point()
	else:
		camera.position = defaultPos
