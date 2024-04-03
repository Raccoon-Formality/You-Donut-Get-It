extends Control

@onready var volume_label = $volume_label
@onready var sense_label = $sense_label

func _ready():
	$volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$sense_slider.value = Global.sensitivity
	volume_label.text = "Volume:"
	sense_label.text = "Sensitivity:"

func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	volume_label.text = str(value)


func _on_sense_slider_value_changed(value):
	Global.sensitivity = value
	sense_label.text = str(value)


func _on_volume_slider_drag_ended(_value_changed):
	volume_label.text = "Volume:"


func _on_sense_slider_drag_ended(_value_changed):
	sense_label.text = "Sensitivity:"


func _on_check_box_toggled(toggled_on):
	set_graphics(toggled_on)

func set_graphics(boolean):
	if boolean:
		get_tree().root.set_content_scale_mode(Window.CONTENT_SCALE_MODE_VIEWPORT)
	else:
		get_tree().root.set_content_scale_mode(Window.CONTENT_SCALE_MODE_CANVAS_ITEMS)


