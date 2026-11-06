extends Node

const FICHIER := "user://parametres.cfg"

# 0 = Facile, 1 = Normal, 2 = Difficile
var difficulte := 1

func _ready() -> void:
	charger()

func sauvegarder() -> void:
	var config := ConfigFile.new()
	config.set_value("audio", "musique", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musique")))
	config.set_value("audio", "effets", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effets")))
	config.set_value("jeu", "difficulte", difficulte)
	config.save(FICHIER)

func charger() -> void:
	var config := ConfigFile.new()
	if config.load(FICHIER) != OK:
		return
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musique"), config.get_value("audio", "musique", 0.0))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effets"), config.get_value("audio", "effets", 0.0))
	difficulte = config.get_value("jeu", "difficulte", 1)
