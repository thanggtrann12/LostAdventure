extends "res://MenuScene/scripts/BaseDisplayItemList.gd"

const RESOLUTION_DICTIONARY: Dictionary = {
	"1152 X 648": Vector2i(1152, 648),
	"1280 X 720": Vector2i(1278, 718),
	"1920 X 1080": Vector2i(1918, 1078),
}


func _ready() -> void:
	update_items(RESOLUTION_DICTIONARY)
	var index = 0
	var window_size = Vector2i(DisplayServer.window_get_size())
	for res in RESOLUTION_DICTIONARY.values():
		if DisplayServer.window_get_size().x == res.x:
			items.selected = index
			break
		else:
			index += 1
