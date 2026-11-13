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
	
func est_sol(t: Vector2i) -> bool:
	return get_cell_atlas_coords(t) == SOL

func tuile_de(pos: Vector2) -> Vector2i:
	return local_to_map(to_local(pos))

func centre_de(t: Vector2i) -> Vector2:
	return to_global(map_to_local(t))

func estimation(a: Vector2i, b: Vector2i) -> int:
	return abs(a.x - b.x) + abs(a.y - b.y)

func chemin(depart: Vector2i, arrivee: Vector2i) -> Array[Vector2i]:
	var ouverts: Array[Vector2i] = [depart]
	var venu_de := {}
	var g := {depart: 0}
	var f := {depart: estimation(depart, arrivee)}

	while not ouverts.is_empty():
		var courant: Vector2i = ouverts[0]
		for t in ouverts:
			if f[t] < f[courant]:
				courant = t

		if courant == arrivee:
			var resultat: Array[Vector2i] = [courant]
			while venu_de.has(courant):
				courant = venu_de[courant]
				resultat.push_front(courant)
			return resultat

		ouverts.erase(courant)
		for dir in [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]:
			var v: Vector2i = courant + dir
			if not est_sol(v):
				continue
			var nouveau_g: int = g[courant] + 1
			if nouveau_g < g.get(v, 999999):
				venu_de[v] = courant
				g[v] = nouveau_g
				f[v] = nouveau_g + estimation(v, arrivee)
				if not ouverts.has(v):
					ouverts.append(v)

	return []
