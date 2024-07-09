extends Control
@onready var input_name: Label = $HBoxContainer/InputName

func set_input_label(name):
	if name:
		input_name.text = name
