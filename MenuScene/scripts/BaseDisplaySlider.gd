extends Control
@onready var volume_slider: HSlider = $HSlider

signal Change(value)

func _on_value_changed(value: float) -> void:
	Change.emit(value)

func _ready() -> void:
	var volume = SettingsManager.load_audio_settings()
	print(volume)
	if volume[0]:
		match name:
			"MasterVolume":
				volume_slider.value = volume[0]
				AudioServer.set_bus_volume_db(0,linear_to_db(volume[0]))
			"SFXVolume":
				volume_slider.value = volume[1]
				AudioServer.set_bus_volume_db(1,linear_to_db(volume[1]))
			"MusicVolume":
				volume_slider.value = volume[2]
				AudioServer.set_bus_volume_db(2,linear_to_db(volume[2]))
