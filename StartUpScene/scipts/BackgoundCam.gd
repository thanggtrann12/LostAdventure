extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	velocity.x = 300
	move_and_slide()
