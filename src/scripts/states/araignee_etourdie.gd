extends BaseState

@export var araignee: Araignee
@export var duree := 2.0

var minuteur := 0.0

func enter() -> void:
	minuteur = duree
	araignee.arrete()
	araignee.modulate = Color(0.6, 0.6, 1.0)

func exit() -> void:
	araignee.modulate = Color.WHITE

func physics_update(delta: float) -> void:
	minuteur -= delta
	if minuteur <= 0:
		Transitioned.emit(self, "patrouille")
