extends CharacterBody2D
class_name Araignee

@export var vitesse := 60.0

var labyrinthe
var cible: Node2D
var chemin: Array[Vector2i] = []
var minuteur := 0.0

func _physics_process(delta: float) -> void:
	if not labyrinthe or not cible:
		return

	minuteur -= delta
	if minuteur <= 0:
		minuteur = 0.5
		chemin = labyrinthe.chemin(labyrinthe.tuile_de(global_position), labyrinthe.tuile_de(cible.global_position))
		if not chemin.is_empty():
			chemin.remove_at(0)

	if chemin.is_empty():
		velocity = Vector2.ZERO
	else:
		var point: Vector2 = labyrinthe.centre_de(chemin[0])
		if global_position.distance_to(point) < 2:
			chemin.remove_at(0)
		else:
			velocity = global_position.direction_to(point) * vitesse

	move_and_slide()
