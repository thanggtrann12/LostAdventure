extends Control
@onready var items: OptionButton = $Items

signal Change(mode)

func update_items(item_list: Dictionary):
	for key in item_list.keys():
		items.add_item(key)
func _on_items_item_selected(index: int) -> void:
	Change.emit(index)
