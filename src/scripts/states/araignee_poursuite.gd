extends BaseState

@export var araignee: Araignee
@export var temps_oubli := 3.0

var minuteur := 0.0
var oubli := 0.0

func enter() -> void:
	minuteur = 0.0
	oubli = temps_oubli

func physics_update(delta: float) -> void:
	if araignee.voit_fourmi():
		oubli = temps_oubli
	else:
		oubli -= delta
		if oubli <= 0:
			Transitioned.emit(self, "patrouille")
			return

	minuteur -= delta
	if minuteur <= 0:
		minuteur = 0.5
		araignee.aller_vers(araignee.labyrinthe.tuile_de(araignee.cible.global_position))

	araignee.avancer()
