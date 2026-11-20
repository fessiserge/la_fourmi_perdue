extends Control

func _ready() -> void:
	%RejouerButton.pressed.connect(_on_rejouer)
	%MenuButton.pressed.connect(_on_menu)
	%RejouerButton.grab_focus()

func _on_rejouer() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
