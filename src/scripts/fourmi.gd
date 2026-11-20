extends CharacterBody2D
class_name Fourmi

@export var vitesse_max := 180.0
@export var acceleration := 1200.0
@export var friction := 1400.0

var invincible := false

func lire_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func avancer(direction: Vector2, delta: float) -> void:
	velocity = velocity.move_toward(direction * vitesse_max, acceleration * delta)
	$Sprite2D.rotation = direction.angle() + PI / 2

func freiner(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func _physics_process(delta: float) -> void:
	move_and_slide()

func repousser(depuis: Vector2) -> void:
	velocity = (global_position - depuis).normalized() * 450
	invincible = true
	var tween := create_tween().set_loops(8)
	tween.tween_property($Sprite2D, "modulate:a", 0.2, 0.1)
	tween.tween_property($Sprite2D, "modulate:a", 1.0, 0.1)
	await get_tree().create_timer(1.6).timeout
	invincible = false
