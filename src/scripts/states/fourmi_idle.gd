extends BaseState

@export var fourmi : Fourmi

func physics_update(delta: float) -> void:
	fourmi.freiner(delta)

	if fourmi.lire_direction() != Vector2.ZERO:
		Transitioned.emit(self, "walk")
