extends "res://MenuScene/scripts/BaseDisplayItemList.gd"
const VSYNC_DICTIONARY: Dictionary = {
	"Disable" : 0,
	"Enable" : 1,
	"Adaptive" : 2,
	"MailBox" : 3,
}


func _ready() -> void:
	update_items(VSYNC_DICTIONARY)
	items.selected = DisplayServer.window_get_vsync_mode()
