extends Control
@onready var input_name: Label = $HBoxContainer/InputName
@onready var items: Button = $HBoxContainer/Items

signal Change


func change_key_to(key):
	items.text = key
	items.shortcut = Shortcut.new()
	var input_key = InputEventKey.new()
	input_key.keycode = key.unicode_at(0)

	items.shortcut.events = [input_key]

var action = ""
 
func _ready():
	set_process_unhandled_key_input(false)
	display_key()
 
func display_key():
	items.text = InputMap.action_get_events(SettingsManager.INPUT_ACTION_LIST.keys()[get_index()])[0].as_text()
	input_name.text = SettingsManager.INPUT_ACTION_LIST.keys()[get_index()]
 
func remap_action_to(event):
	InputMap.action_erase_events(SettingsManager.INPUT_ACTION_LIST.keys()[get_index()])
	InputMap.action_add_event(SettingsManager.INPUT_ACTION_LIST.keys()[get_index()], event)

	items.text = event.as_text()
	Change.emit()
 
func _on_pressed():
	set_process_unhandled_key_input(true)
	items.text = "press any key"
 
 
func _unhandled_key_input(event):
	remap_action_to(event)
	set_process_unhandled_key_input(false)
	release_focus()
