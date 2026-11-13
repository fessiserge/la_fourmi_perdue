extends Node2D
const ARAIGNEE = preload("res://scenes/araignee.tscn")
var suivre := false

func _ready() -> void:
	var lab = $Labyrinthe
	var cam = $Camera2D
	$Fourmi.position = lab.position_de(lab.case_depart)
	$Reine.position = lab.position_de(lab.case_reine)
	$Reine.fourmi_arrivee.connect(_on_victoire)

	var taille := Vector2(lab.largeur * 2 + 1, lab.hauteur * 2 + 1) * 32
	var ecran := get_viewport_rect().size
	cam.limit_left = 0
	cam.limit_top = 0
	cam.limit_right = int(taille.x)
	cam.limit_bottom = int(taille.y)

	if GameManager.difficulte < 2:
		var zoom := maxf(ecran.x / taille.x, ecran.y / taille.y)
		cam.zoom = Vector2(zoom, zoom)
		cam.position = taille / 2
	else:
		var zoom := ecran.y / taille.y
		cam.zoom = Vector2(zoom, zoom)
		await apercu(taille, ecran / zoom)
		suivre = true
	var araignee = ARAIGNEE.instantiate()
	araignee.labyrinthe = lab	
	araignee.cible = $Fourmi
	araignee.position = lab.position_de(lab.case_reine)
	add_child(araignee)

func apercu(taille: Vector2, vue: Vector2) -> void:
	var cam = $Camera2D
	$Fourmi.process_mode = Node.PROCESS_MODE_DISABLED
	cam.position = vue / 2
	var tween := create_tween()
	tween.tween_interval(0.5)
	tween.tween_property(cam, "position:x", taille.x - vue.x / 2, 4.0)
	tween.tween_interval(0.5)
	tween.tween_property(cam, "position", $Fourmi.position, 1.5)
	await tween.finished
	$Fourmi.process_mode = Node.PROCESS_MODE_INHERIT

func _process(delta: float) -> void:
	if suivre:
		$Camera2D.position = $Fourmi.position
		
func _on_victoire() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/menus/victoire.tscn")
