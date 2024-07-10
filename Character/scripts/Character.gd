extends CharacterBody2D

@export var speed = 200
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var target = position

func _input(event):
	if event.is_action_pressed("move"):
		target = get_global_mouse_position()
	if event.is_action_pressed("attack"):
		animation_player.play("attack_1")
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	update_animation_direction(velocity)
	if position.distance_to(target) > 10:
		move_and_slide()

func update_animation_direction(velocity):
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
