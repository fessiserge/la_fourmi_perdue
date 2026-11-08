extends TileMapLayer

const SOL := Vector2i(0, 0)
const MUR := Vector2i(1, 0)

@export var largeur := 17
@export var hauteur := 9

var case_depart := Vector2i.ZERO
var case_reine := Vector2i.ZERO
var distance_max := 0

func _ready() -> void:
	match GameManager.difficulte:
		0:
			largeur = 9
			hauteur = 5
		1:
			largeur = 17
			hauteur = 9
		2:
			largeur = 35
			hauteur = 10
	generer()

func generer() -> void:
	clear()
	for x in range(largeur * 2 + 1):
		for y in range(hauteur * 2 + 1):
			set_cell(Vector2i(x, y), 0, MUR)
	creuser(Vector2i.ZERO)
func creuser(depart: Vector2i) -> void:
	var pile: Array[Vector2i] = [depart]
	var visitees := {depart: true}
	set_cell(depart * 2 + Vector2i.ONE, 0, SOL)

	while not pile.is_empty():
		var case_actuelle: Vector2i = pile.back()
		var voisines: Array[Vector2i] = []

		for dir in [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]:
			var v: Vector2i = case_actuelle + dir
			if v.x >= 0 and v.y >= 0 and v.x < largeur and v.y < hauteur and not visitees.has(v):
				voisines.append(v)

		if voisines.is_empty():
			pile.pop_back()
		else:
			var suivante: Vector2i = voisines.pick_random()
			visitees[suivante] = true
			set_cell(case_actuelle * 2 + Vector2i.ONE + (suivante - case_actuelle), 0, SOL)
			set_cell(suivante * 2 + Vector2i.ONE, 0, SOL)
			pile.push_back(suivante)
			if pile.size() > distance_max:
				distance_max = pile.size()
				case_reine = suivante
			
func position_de(case_lab: Vector2i) -> Vector2:
	return to_global(map_to_local(case_lab * 2 + Vector2i.ONE))
