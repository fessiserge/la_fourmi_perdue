extends Node2D
const ARAIGNEE = preload("res://scenes/araignee.tscn")
const COEUR = preload("res://assets/sprites/atlas_fourmi/decorations/coeur.png")
const MIETTE = preload("res://scenes/miette.tscn")
var suivre := false
var temps_restant := 0.0
var en_jeu := false
var miettes_total := 0
var miettes_ramassees := 0
func _ready() -> void:
	var lab = $Labyrinthe
	var cam = $Camera2D
	GameManager.vies = 3
	maj_coeurs()
	temps_restant = [90.0, 150.0, 240.0][GameManager.difficulte]
	maj_chrono()
	$Fourmi.position = lab.position_de(lab.case_depart)
	$Reine.position = lab.position_de(lab.case_reine)
	placer_miettes()
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
	araignee.a_mordu.connect(_on_mordue)
	araignee.position = lab.position_de(lab.case_reine)
	add_child(araignee)
	en_jeu = true

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
		
	if en_jeu:
		temps_restant -= delta
		maj_chrono()
		if temps_restant <= 0:
			en_jeu = false
			get_tree().change_scene_to_file.call_deferred("res://scenes/menus/defaite.tscn")
		
func _on_victoire() -> void:
	if miettes_ramassees < miettes_total:
		var tween := create_tween()
		%Miettes.modulate = Color.RED
		tween.tween_property(%Miettes, "modulate", Color.WHITE, 1.0)
		return
	en_jeu = false
	get_tree().change_scene_to_file.call_deferred("res://scenes/menus/victoire.tscn")

func _on_mordue(araignee) -> void:
	if $Fourmi.invincible:
		return
	GameManager.vies -= 1
	maj_coeurs()
	print("Vies : ", GameManager.vies)
	if GameManager.vies <= 0:
		get_tree().change_scene_to_file.call_deferred("res://scenes/menus/defaite.tscn")
	else:
		$Fourmi.repousser(araignee.global_position)
	
func maj_coeurs() -> void:
	for c in %Coeurs.get_children():
		c.queue_free()
	for i in GameManager.vies:
		var t := TextureRect.new()
		t.texture = COEUR
		t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		t.custom_minimum_size = Vector2(32, 32)
		%Coeurs.add_child(t)

func maj_chrono() -> void:
	var t := int(ceil(maxf(temps_restant, 0)))
	%Chrono.text = "%d:%02d" % [t / 60, t % 60]
	

func placer_miettes() -> void:
	var lab = $Labyrinthe
	miettes_total = [3, 5, 8][GameManager.difficulte]
	miettes_ramassees = 0
	var prises := [lab.case_depart * 2 + Vector2i.ONE, lab.case_reine * 2 + Vector2i.ONE]
	while prises.size() < miettes_total + 2:
		var t: Vector2i = lab.tuile_au_hasard()
		if t in prises:
			continue
		prises.append(t)
		var m = MIETTE.instantiate()
		m.position = lab.centre_de(t)
		m.ramassee.connect(_on_miette_ramassee)
		add_child(m)
		move_child(m, $Fourmi.get_index())
	maj_miettes()

func _on_miette_ramassee() -> void:
	miettes_ramassees += 1
	maj_miettes()

func maj_miettes() -> void:
	%Miettes.text = "Miettes : %d / %d" % [miettes_ramassees, miettes_total]
