extends Node

const SETTING_FILE_PATH: String = "user://settings.cfg"

const DEFAULT_WINDOW_MODE = DisplayServer.WINDOW_MODE_WINDOWED
const DEFAULT_WINDOW_FLAG = DisplayServer.WINDOW_FLAG_BORDERLESS
const DEFAULT_WINDOW_FLAG_STATE = false
const DEFAULT_WINDOW_SIZE = Vector2i(1152, 648)
const DEFAULT_WINDOW_VSYNC_MODE = DisplayServer.VSYNC_DISABLED

var FileHandler = ConfigFile.new()

const INPUT_ACTION_LIST: Dictionary = {
	"Skill 1":"Q", "Skill 2":"W", "Skill 3":"E", "Skill 4":"R",	"Dash":"Shift",
	 "Toggle Inventory":"Tab", "Toggle Map":"M", "Toggle Skill":"K"}


func _ready() -> void:
	load_window_settings()
	get_input_actions_settings()

func save_back_ground_music(music_name):
	FileHandler.set_value("Audio", "background_music", music_name)
	FileHandler.save(SETTING_FILE_PATH)

func load_back_ground_music():
	if FileHandler.load(SETTING_FILE_PATH) == OK:
		return FileHandler.get_value("Audio", "background_music")

func save_setings():
	get_window_settings()
	get_audio_settings()
	get_input_actions_settings()
	var error = FileHandler.save(SETTING_FILE_PATH)
	if error != OK:
		print("Error saving settings")
	else:
		print("Settings saved successfully")
	
func load_setting():
	pass

func get_window_settings():
	FileHandler.set_value("VideoSettings", "screen_resolution",  DisplayServer.window_get_size())
	FileHandler.set_value("VideoSettings", "display_mode",  DisplayServer.window_get_mode())
	FileHandler.set_value("VideoSettings", "vsync", DisplayServer.window_get_vsync_mode())
	FileHandler.set_value("VideoSettings", "display_flag", DisplayServer.window_get_flag(DEFAULT_WINDOW_FLAG))
	FileHandler.set_value("VideoSettings", "texture_render", ProjectSettings.get_setting("rendering/textures/canvas_textures/default_texture_filter"))
	

func load_window_settings():
	if FileHandler.load(SETTING_FILE_PATH) == OK:
		DisplayServer.window_set_mode(FileHandler.get_value("VideoSettings", "display_mode"))
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, FileHandler.get_value("VideoSettings", "display_flag"))
		DisplayServer.window_set_size(FileHandler.get_value("VideoSettings", "screen_resolution"))
		DisplayServer.window_set_vsync_mode(FileHandler.get_value("VideoSettings", "vsync"))
		ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", FileHandler.get_value("VideoSettings", "texture_render"))
		
func get_audio_settings():
	var master_vol = db_to_linear(AudioServer.get_bus_volume_db(0))
	FileHandler.set_value("Audio", "master",  master_vol)
	var music_vol = db_to_linear(AudioServer.get_bus_volume_db(1))
	FileHandler.set_value("Audio", "music",  music_vol)
	var sfx_vol = db_to_linear(AudioServer.get_bus_volume_db(2))
	FileHandler.set_value("Audio", "sfx",  sfx_vol)

func load_audio_settings():
	if FileHandler.load(SETTING_FILE_PATH) == OK:
		var master_vol = FileHandler.get_value("Audio", "master")
		var music_vol = FileHandler.get_value("Audio", "music")
		var sfx_vol = FileHandler.get_value("Audio", "sfx")
		return [master_vol, sfx_vol, music_vol]

func get_input_actions_settings():
	for action in INPUT_ACTION_LIST.keys():
		if InputMap.has_action(action):
			var events = InputMap.action_get_events(action)
			FileHandler.set_value("Inputs", action,  events)

func load_input_actions_settings():
	var events = []
	for action in INPUT_ACTION_LIST.keys():
		var event = FileHandler.get_value("Inputs", action)
		events.append(event)
	return events
