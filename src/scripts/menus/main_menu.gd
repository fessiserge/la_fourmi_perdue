extends Control

func _ready() -> void:
	%JouerButton.pressed.connect(_on_jouer)
	%ConfigButton.pressed.connect(_on_config)
	%InstructionsButton.pressed.connect(_on_instructions)
	%ResultatsButton.pressed.connect(_on_resultats)
	%QuitterButton.pressed.connect(_on_quitter)

func _on_jouer() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_config() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/config_menu.tscn")

func _on_instructions() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/instructions_menu.tscn")

func _on_resultats() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/resultats_menu.tscn")

func _on_quitter() -> void:
	get_tree().quit()
