extends Control

func _ready() -> void:
	%JouerButton.pressed.connect(_on_jouer)
	%ConfigButton.pressed.connect(_on_config)
	%InstructionsButton.pressed.connect(_on_instructions)
	%ResultatsButton.pressed.connect(_on_resultats)
	%QuitterButton.pressed.connect(_on_quitter)
	%JouerButton.grab_focus()
	$TextureRect.pivot_offset = $TextureRect.size / 2
	var tween = create_tween().set_loops()
	tween.tween_property($TextureRect, "scale", Vector2(1.05, 1.05), 4.0)
	tween.tween_property($TextureRect, "scale", Vector2(1.0, 1.0), 4.0)

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
