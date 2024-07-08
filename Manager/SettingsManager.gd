extends Node

const SETTING_FILE_PATH: String = "user://settings.cfg"

const DEFAULT_WINDOW_MODE = DisplayServer.WINDOW_MODE_WINDOWED
const DEFAULT_WINDOW_FLAG = DisplayServer.WINDOW_FLAG_BORDERLESS
const DEFAULT_WINDOW_FLAG_STATE = false
const DEFAULT_WINDOW_SIZE = Vector2i(1152, 648)
const DEFAULT_WINDOW_VSYNC_MODE = DisplayServer.VSYNC_DISABLED

var FileHandler = ConfigFile.new()

func _ready() -> void:
	load_window_settings()

func save_back_ground_music(name):
	FileHandler.set_value("Audio", "background_music", name)
	FileHandler.save(SETTING_FILE_PATH)

func load_back_ground_music():
	if FileHandler.load(SETTING_FILE_PATH) == OK:
		return FileHandler.get_value("Audio", "background_music")

func save_setings():
	get_window_settings()
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
