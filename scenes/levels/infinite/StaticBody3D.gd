extends StaticBody3D

var player_entered = false
@onready var player = get_tree().get_nodes_in_group("player_body")[0]

func _process(delta):
	if player_entered:
		#player.linear_velocity.x += delta
		player.apply_central_force(Vector3(500,0,0))

func _on_area_3d_body_entered(body):
	if body.is_in_group("player_body"):
		player_entered = true


func _on_area_3d_body_exited(body):
	if body.is_in_group("player_body"):
		player_entered = false
