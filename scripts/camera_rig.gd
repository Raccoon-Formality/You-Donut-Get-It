extends Node3D

@onready var player = get_parent().get_node("Player")

func _process(_delta):
	global_position = lerp(global_position, player.global_position, 0.2)
