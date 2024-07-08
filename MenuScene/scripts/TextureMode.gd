extends "res://MenuScene/scripts/BaseDisplayItemList.gd"

const TEXTURE_RENDERING_NODE: Dictionary = {
	"Nearest" : 0,
	"Linear" : 1,
	"Linear Mipmap" : 2,
	"Nearest Mipmap" : 3,
}


func _ready() -> void:
	update_items(TEXTURE_RENDERING_NODE)
	items.selected = ProjectSettings.get_setting("rendering/textures/canvas_textures/default_texture_filter")
