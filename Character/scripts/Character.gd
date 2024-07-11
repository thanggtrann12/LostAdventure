extends CharacterBody2D

@export var projectile_node : PackedScene
@export var ghost_effect : PackedScene

@export var speed = 200
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var click_point: Area2D = $ClickPoint
@onready var ghost_timer: Timer = $GhostTimer

@onready var attack_range: Area2D = $AttackRange

var destination = position
var target_position: Vector2 = Vector2.ZERO

var frame_width: int = 100
var frame_height: int = 100
var frames_per_row: int = 8


var _can_move : bool = true

var can_move : bool:
	set(value):
		_can_move = value
		if not value:
			speed = 0
		else:
			speed = 200

func _ready() -> void:
	destination = position
	attack_range.visible = false

func _input(event):
	if event.is_action_pressed("move"):
		destination = get_global_mouse_position()
	if event.is_action_pressed("Show AttackRange"):
		attack_range.visible = true
	elif event.is_action_released("Show AttackRange"):
		attack_range.visible = false
	if event.is_action_pressed("Skill 1"):
		multiple_shot()
	if event.is_action_pressed("Dash"):
		dash()
	if event.is_action_pressed("attack"):
		click_point.visible = true
		var mouse_position = event.position
		var radius = 0
		if attack_range.get_child(0).shape is CircleShape2D:
			var circle_shape = attack_range.get_child(0).shape as CircleShape2D
			radius = circle_shape.radius
		click_point.global_position = mouse_position
		if mouse_position.x - position.x <= radius:
			if mouse_position.x < position.x:
				sprite.flip_h = true
			elif mouse_position.x > position.x:
				sprite.flip_h = false
			if click_point.has_overlapping_areas():
				target_position = click_point.global_position
				play_animation("attack_1")
		click_point.visible = false

func _physics_process(_delta):
	if _can_move:
		velocity = position.direction_to(destination) * speed
		if position.distance_to(destination) > 10:
			move_and_slide()
			update_animation_direction()
			animation.play("walk")
		else:
			velocity = Vector2.ZERO
			animation.play("idle")

func update_animation_direction():
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

func play_animation(type = "normal"):
	_can_move = false
	animation.play(type)

func shot(tar_pos = position):
	var projectile = projectile_node.instantiate()
	projectile.position = Vector2(tar_pos.x + 4, tar_pos.y + 4)
	projectile.damage = 100
	projectile.set_direction(sprite.flip_h, target_position)
	get_tree().current_scene.add_child(projectile)

func multiple_shot():
	var frame_texture = get_frame_as_texture($Sprite2D.frame)

	pass

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_1":
		_can_move = true
		destination = position
		
func calculate_raycast_target(start_pos, end_pos, length):
	var direction = (end_pos - start_pos).normalized()
	return start_pos + direction * length

func add_ghost():
	var ghost = ghost_effect.instantiate()
	ghost.set_property(position, $Sprite2D.scale, get_frame_as_texture($Sprite2D.frame))
	get_tree().current_scene.add_child(ghost)

func dash():
	ghost_timer.start()
	if velocity.length() == 0:
		return
	var dash_distance = 100
	var dash_destination = position + velocity.normalized() * dash_distance
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", dash_destination, 0.2)
	await tween.finished
	ghost_timer.stop()
	
func _on_ghost_timer_timeout() -> void:
	add_ghost()



func get_frame_as_texture(frame_index: int) -> AtlasTexture:
	var x = (frame_index % frames_per_row) * frame_width
	var y = int(frame_index / frames_per_row) * frame_height

	# Create an AtlasTexture
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = $Sprite2D.texture
	atlas_texture.region = Rect2(x, y, frame_width, frame_height)

	return atlas_texture
