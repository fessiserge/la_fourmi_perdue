extends Control

var bus_musique := AudioServer.get_bus_index("Musique")
var bus_effets := AudioServer.get_bus_index("Effets")

func _ready() -> void:
	%MusiqueSlider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_musique))
	%EffetsSlider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_effets))

	%MusiqueSlider.value_changed.connect(_on_musique_changed)
	%EffetsSlider.value_changed.connect(_on_effets_changed)
	%RetourButton.pressed.connect(_on_retour)
	%DifficulteOption.selected = GameManager.difficulte
	%DifficulteOption.item_selected.connect(_on_difficulte_changed)
	%MusiqueSlider.grab_focus()

func _on_musique_changed(valeur: float) -> void:
	AudioServer.set_bus_volume_db(bus_musique, linear_to_db(valeur))

func _on_effets_changed(valeur: float) -> void:
	AudioServer.set_bus_volume_db(bus_effets, linear_to_db(valeur))

func _on_retour() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _on_difficulte_changed(index: int) -> void:
	GameManager.difficulte = index
