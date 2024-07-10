extends Control

signal Change(toggled)


func _on_check_button_toggled(toggled_on: bool) -> void:
	Change.emit(toggled_on)
