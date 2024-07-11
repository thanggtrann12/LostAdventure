extends Area2D

@export var speed: float = 400.0
@onready var attack_range: float = 300

var acceleration: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var damage: float = 1.0
var initial_position: Vector2
var distance_traveled: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var destination: Vector2 = Vector2.ZERO

func _ready() -> void:
	initial_position = position  # Store the initial position when the projectile is created

func _on_screen_exited() -> void:
	queue_free()

func _process(delta: float) -> void:
	distance_traveled = initial_position.distance_to(position)  # Calculate the distance traveled
	if distance_traveled >= attack_range:
		print("Out of range")
		queue_free()

	acceleration = (destination - position).normalized() * speed
	velocity += acceleration * delta
	velocity = velocity.normalized() * speed  # Limit velocity to maintain constant speed
	rotation = velocity.angle()
	position += velocity * delta

func set_direction(flip_direction: bool, to_destination: Vector2) -> void:
	destination = to_destination
	if flip_direction:
		direction = (destination - position).normalized()
	else:
		direction = Vector2.RIGHT if destination.x > position.x else Vector2.LEFT

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, direction)
		queue_free()
	
