extends BaseState

@export var fourmi : Fourmi

func physics_update(delta: float) -> void:
	var direction := fourmi.lire_direction()

	if direction == Vector2.ZERO:
		Transitioned.emit(self, "idle")
		return

	fourmi.avancer(direction, delta)
