extends Control

func _ready() -> void:
	%RetourButton.pressed.connect(_on_retour)
	%RetourButton.grab_focus()

func _on_retour() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
