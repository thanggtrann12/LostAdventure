extends CharacterBody2D
@onready var animation: AnimationPlayer = $AnimationPlayer

@export var damage_node : PackedScene
@export var knockback_force = 20  # Adjustable knockback force
var immune : bool = false


func take_damage(amount, knockback_dir: Vector2):
	if damage_node != null:
		var damage = damage_node.instantiate()
		if knockback_dir == Vector2.LEFT:
			animation.play("right")
		elif knockback_dir == Vector2.RIGHT	:
			animation.play("left")
		damage.find_child("Label").text = str(amount)
		damage.position = position
		
		get_tree().current_scene.add_child(damage)
		velocity = knockback_dir.normalized() * knockback_force
		move_and_collide(velocity)
