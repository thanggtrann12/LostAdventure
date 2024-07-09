extends Node2D

@onready var button_container: VBoxContainer = $Background/UI/ButtonContainer
@onready var settings_tab: Control = $Background/UI/SettingsTab
@onready var background_audio: AudioStreamPlayer = $BackgroundAudio
func _ready() -> void:
	for button in button_container.get_children():
		button.pressed.connect(_on_button_pressed.bind(button))
		button.mouse_entered.connect(_on_button_mouse_entered.bind(button))
		button.mouse_exited.connect(_on_button_mouse_exited.bind(button))


func _on_button_pressed(button: Button) -> void:
	match button.name:
		"Cont":
			get_tree().change_scene_to_file("res://Character/scenes/CharacterSeletion.tscn")
			pass
		"Start":
			Transitions.transition()
			await Transitions.on_transition_finished
			print("oke")
			pass
		"Settings":
			settings_tab.visible = true
			button_container.visible = !settings_tab.visible
		"Credits":
			# Handle "Credits" button pressed
			pass
		"Exit":
			get_tree().quit()

func _on_button_mouse_entered(button: Button) -> void:
	button.get_child(0).visible = true

func _on_button_mouse_exited(button: Button) -> void:
	button.get_child(0).visible = false
