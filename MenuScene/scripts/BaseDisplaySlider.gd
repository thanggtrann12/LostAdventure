extends Control

signal Change(value)

func _on_value_changed(value: float) -> void:
	Change.emit(value)
