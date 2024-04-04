extends CanvasLayer

@onready var mouse1 = $MouseMove
@onready var mouse2 = $MouseMove2
@onready var mousePos = mouse1.position
var counter = 0.0

"""
func _process(delta):
	counter += delta
	mouse1.position.x = mousePos.x + sin(counter) * 25.0
	mouse1.position.y = mousePos.y + sin(counter/2.0) * 50.0
	mouse2.position.x = mousePos.x + sin(counter) * 25.0
	mouse2.position.y = mousePos.y + sin(counter/2.0) * 50.0
"""
