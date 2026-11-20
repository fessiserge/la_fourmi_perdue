extends Area2D

signal ramassee

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Fourmi:
		ramassee.emit()
		set_deferred("monitoring", false)
		var tween := create_tween()
		tween.tween_property(self, "scale", Vector2(1.6, 1.6), 0.15)
		tween.parallel().tween_property(self, "modulate:a", 0.0, 0.15)
		tween.tween_callback(queue_free)
