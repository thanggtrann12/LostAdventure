extends Control

@onready var video_container: VBoxContainer = $TabContainer/Video/VideoSettingContainer/VideoContainer
@onready var sound_container: VBoxContainer = $TabContainer/Sound/SoundSettingContainer/SoundContainer

@onready var settings_list = video_container.get_children() + sound_container.get_children()

@onready var save: Button = $Button/Save

@export var parrent_node: Node2D

var is_value_changed: bool = false:
	set(value):
		is_value_changed = value
		save.disabled = !value


func _on_back_pressed() -> void:
	if is_value_changed: 
		print("not save yet")
	else:
		if parrent_node:
			parrent_node.visible = true
			parrent_node.find_child("ButtonContainer").visible = true
			visible = !parrent_node.visible

func _ready() -> void:
	for setting in settings_list:
		setting.connect("Change", Callable(self, "_on_change").bind(setting))
	save.disabled = true
	var audio = parrent_node.find_child("BackgroundAudio")
	audio.stop()
	audio.stream = load("res://Audio/Source/" + SettingsManager.load_back_ground_music())
	audio.play()

func _on_change(change, control: Control):
	is_value_changed = true
	match control.name:
		"WindowMode":
			match change:
				0: #Fullscreen
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
					DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
				1: #Windowed
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
				2: #Borderless
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
				3: #Borderless Fullscreen
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
					DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		"WindowSize":
			DisplayServer.window_set_size(control.RESOLUTION_DICTIONARY.values()[change])
		"Vsync":
			DisplayServer.window_set_vsync_mode(change)
		"TextureMode":
			ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", change)
		"MasterVolume":
			set_volume(0, change)
		"MusicVolume":
			set_volume(2, change)
		"SFXVolume":
			set_volume(1, change)
		"MusicList":
			var audio = parrent_node.find_child("BackgroundAudio")
			audio.stop()
			audio.stream = load(control.music_path+control.music_list.keys()[change])
			audio.play()


func _on_save_pressed() -> void:
	is_value_changed = false
	SettingsManager.save_setings()
	SettingsManager.save_back_ground_music(parrent_node.find_child("BackgroundAudio").stream.resource_path.get_file())

func set_volume(bus, value):
	AudioServer.set_bus_volume_db(bus,linear_to_db(value))
