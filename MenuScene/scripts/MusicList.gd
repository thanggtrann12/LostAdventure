extends "res://MenuScene/scripts/BaseDisplayItemList.gd"
var music_path = "res://Audio/Source/"
var music_list: Dictionary = {}


func _ready() -> void:
	update_items(get_music_file_names(music_path))
	if SettingsManager.load_back_ground_music() in music_list.keys():
		items.selected = music_list[SettingsManager.load_back_ground_music()]
		
func get_music_file_names(directory: String) -> Dictionary:
	var dir = DirAccess.open(directory)
	
	var index = 0
	dir.list_dir_begin()
   
	var filename = dir.get_next()
	while filename != "":
		if not filename.ends_with(".import"):
			music_list[filename] = index
			index += 1
		filename = dir.get_next()

	dir.list_dir_end()
	return music_list
