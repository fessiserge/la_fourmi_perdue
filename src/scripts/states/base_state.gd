extends Node
class_name BaseState

signal Transitioned(state: BaseState, new_state_name: String)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
