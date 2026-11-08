extends Area2D

signal fourmi_arrivee

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Fourmi:
		fourmi_arrivee.emit()
