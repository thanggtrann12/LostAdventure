extends ParallaxBackground

# Ensure old_screen_size is Vector2
func _ready():
	adjust_parallax_to_screen_size()
	get_viewport().connect("size_changed", _on_viewport_size_changed)

func adjust_parallax_to_screen_size():
	var screen_size = get_viewport().size
	var sprite = $ParallaxLayer/BackgroundImage

	if sprite.texture:
		var texture_size = sprite.texture.get_size()
		var scale_x = screen_size.x / texture_size.x
		var scale_y = sprite.ge
		sprite.scale = Vector2(scale_x, scale_y)

func _on_viewport_size_changed():
	adjust_parallax_to_screen_size()
