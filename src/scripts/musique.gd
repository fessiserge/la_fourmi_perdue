extends AudioStreamPlayer

func _ready() -> void:
	bus = "Musique"

func jouer(morceau: AudioStream) -> void:
	if stream == morceau and playing:
		return
	stream = morceau
	play()
