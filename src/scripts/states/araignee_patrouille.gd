extends BaseState

@export var araignee: Araignee

func enter() -> void:
	araignee.aller_vers(araignee.labyrinthe.tuile_au_hasard())

func physics_update(delta: float) -> void:
	if araignee.voit_fourmi():
		Transitioned.emit(self, "poursuite")
		return

	if araignee.chemin.is_empty():
		araignee.aller_vers(araignee.labyrinthe.tuile_au_hasard())

	araignee.avancer()
