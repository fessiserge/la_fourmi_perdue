extends CharacterBody2D
class_name Araignee

@export var vitesse := 60.0
@export var portee_vue := 160.0

var labyrinthe
var cible: Node2D
var chemin: Array[Vector2i] = []

func aller_vers(tuile: Vector2i) -> void:
	chemin = labyrinthe.chemin(labyrinthe.tuile_de(global_position), tuile)
	if not chemin.is_empty():
		chemin.remove_at(0)

func avancer() -> void:
	if chemin.is_empty():
		velocity = Vector2.ZERO
		return
	var point: Vector2 = labyrinthe.centre_de(chemin[0])
	if global_position.distance_to(point) < 2:
		chemin.remove_at(0)
	else:
		velocity = global_position.direction_to(point) * vitesse

func arrete() -> void:
	chemin.clear()
	velocity = Vector2.ZERO

func voit_fourmi() -> bool:
	if global_position.distance_to(cible.global_position) > portee_vue:
		return false
	$Vue.target_position = to_local(cible.global_position)
	$Vue.force_raycast_update()
	return $Vue.get_collider() == cible

func _physics_process(delta: float) -> void:
	move_and_slide()
