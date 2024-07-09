extends Node2D
@onready var texture_progress_bar: TextureProgressBar = $CanvasLayer/TextureProgressBar
@onready var label: Label = $CanvasLayer/Label

var val = 0;

func _ready() -> void:
	texture_progress_bar.max_value = 100
	texture_progress_bar.value = val


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	val += 30 * delta
	label.text =str(round((val / 100 ) * 100)) + " %"
	texture_progress_bar.value = val
	if val >= 100:
		get_tree().change_scene_to_file("res://StartUpScene/scenes/StartupScene.tscn")
