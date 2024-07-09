extends GridContainer

@export var input_package: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	for inputIndex in range(SettingsManager.INPUT_ACTION_LIST.keys().size()):
		var base_display_input_instance = input_package.instantiate()
		add_child(base_display_input_instance)
		var key = SettingsManager.load_input_actions_settings()[inputIndex][0].as_text()
		if key:
			var space_index = key.find(" ")
			get_child(inputIndex).change_key_to(key.substr(0, space_index))
		else:
			get_child(inputIndex).change_key_to(SettingsManager.INPUT_ACTION_LIST.values()[inputIndex])
