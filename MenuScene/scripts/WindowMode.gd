extends "res://MenuScene/scripts/BaseDisplayItemList.gd"
const WINDOW_MODE_ARRAY : Dictionary = {
	"Fullscreen" : 0,
	"Windowed" : 1,
	"Borderless" : 2,
	"Borderless Fullscreen" : 3
}


func _ready() -> void:
	update_items(WINDOW_MODE_ARRAY)
	items.selected = DisplayServer.window_get_mode()
