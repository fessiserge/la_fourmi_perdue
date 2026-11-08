extends Node2D

func _ready() -> void:
	$Fourmi.position = $Labyrinthe.position_de($Labyrinthe.case_depart)
	$Reine.position = $Labyrinthe.position_de($Labyrinthe.case_reine)
