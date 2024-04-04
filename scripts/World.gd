extends Node3D

var part = preload("res://scenes/marker.tscn")

func _ready():
	var firstPart = part.instantiate()
	add_child(firstPart)
	firstPart.emitting = true

	


