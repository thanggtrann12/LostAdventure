extends GridContainer

const BASE_DISPLAY_INPUT = preload("res://MenuScene/scene/BaseDisplayInput.tscn")

var input_list: Array = [
	"Skill 1", "Skill 2", "Skill 3", "Skill 4",
	"Dash", "Toggle Inventory", "Toggle Map", "Toggle Skill"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for inputIndex in range(input_list.size()):
		var base_display_input_instance = BASE_DISPLAY_INPUT.instantiate()
		#base_display_input_instance.set_input_label(input_list[inputIndex]) # Assuming there is a method to set the label
		add_child(base_display_input_instance)
		get_child(inputIndex).set_input_label(input_list[inputIndex])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
