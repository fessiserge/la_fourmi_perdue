extends CharacterBody2D
class_name Fourmi

@export var vitesse_max := 180.0
@export var acceleration := 1200.0
@export var friction := 1400.0

func lire_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func avancer(direction: Vector2, delta: float) -> void:
	velocity = velocity.move_toward(direction * vitesse_max, acceleration * delta)
	$Sprite2D.rotation = direction.angle() + PI / 2

func freiner(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func _physics_process(delta: float) -> void:
	move_and_slide()
