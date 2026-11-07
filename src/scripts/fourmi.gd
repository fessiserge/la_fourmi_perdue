extends CharacterBody2D
class_name Fourmi

@export var vitesse_max := 180.0
@export var acceleration := 1200.0
@export var friction := 1400.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * vitesse_max, acceleration * delta)
		$Sprite2D.rotation = direction.angle() + PI / 2
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
