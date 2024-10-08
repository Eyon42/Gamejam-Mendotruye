class_name BuildingTile
extends Tile

@onready var collision_shape_3d = $CollisionShape3D

@onready var colision_vecino1 = $ColisionVecino/CollisionShape3D
@onready var colision_vecino2 = $ColisionVecino2/CollisionShape3D
@onready var colision_vecino3 = $ColisionVecino3/CollisionShape3D
@onready var colision_vecino4 = $ColisionVecino4/CollisionShape3D
@onready var tipo_label = $TipoLabel


@export var aumento : float = 50
@export var aumento_grande : float = 100
@export var resta : float = -50
@export var resta_grande : float = -100

@export var category: Types.Category

var vecinos : Array

var building_placed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	match category:
		Types.Category.RESIDENCIAL:
			tipo_label.text = "Residencial"
		Types.Category.RECREATIVO:
			tipo_label.text = "Recreativo"
		Types.Category.INDUSTRIAL:
			tipo_label.text = "Industrial"
		Types.Category.COMERCIAL:
			tipo_label.text = "Comercial"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Calcula plata gana segun con respecto a sus vecinos
func _calculate_money_gain(categoria_vecina: Types.Category):
	var money_changed = 0
	if category == Types.Category.RESIDENCIAL:
		if categoria_vecina == Types.Category.RECREATIVO:
			money_changed = aumento_grande
		if categoria_vecina == Types.Category.INDUSTRIAL:
			money_changed = resta_grande
		if categoria_vecina == Types.Category.COMERCIAL:
			money_changed = aumento
	
	if category == Types.Category.INDUSTRIAL:
		if categoria_vecina == Types.Category.RECREATIVO:
			money_changed = resta_grande
		if categoria_vecina == Types.Category.RESIDENCIAL:
			money_changed = resta_grande
		if categoria_vecina == Types.Category.COMERCIAL:
			money_changed = aumento
	
	if category == Types.Category.COMERCIAL:
		if categoria_vecina == Types.Category.RECREATIVO:
			money_changed = aumento_grande
		if categoria_vecina == Types.Category.INDUSTRIAL:
			money_changed = aumento
		if categoria_vecina == Types.Category.RESIDENCIAL:
			money_changed = aumento
			
	if category == Types.Category.RECREATIVO:
		if categoria_vecina == Types.Category.COMERCIAL:
			money_changed = aumento_grande
		if categoria_vecina == Types.Category.INDUSTRIAL:
			money_changed = resta_grande
		if categoria_vecina == Types.Category.RESIDENCIAL:
			money_changed = aumento_grande
			
	return money_changed

func calcular_total_vecinos():
	var suma = 0
	for vecino : BuildingTile in vecinos:
		#print(vecino)
		suma += _calculate_money_gain(vecino.category)
	
	money_gain = suma / 60.0

func enable_lateral_collisions():
	# Turns on all collisions, usually happens when placed
	collision_shape_3d.disabled = false
	colision_vecino1.disabled = false
	colision_vecino2.disabled = false
	colision_vecino3.disabled = false
	colision_vecino4.disabled = false

func _on_colision_vecino_4_area_entered(area):
	# Chequea si el area no es de tipo o si el edificio no está posicionado todavía o si el edificio con el que se está tocando areas no está posicionado todavia
	if not (area is BuildingTile) or not building_placed or not area.building_placed:
		return
	vecinos.append(area)
	calcular_total_vecinos()

func _on_colision_vecino_3_area_entered(area):
	# Chequea si el area no es de tipo o si el edificio no está posicionado todavía o si el edificio con el que se está tocando areas no está posicionado todavia
	if not (area is BuildingTile) or not building_placed or not area.building_placed:
		return
	vecinos.append(area)
	calcular_total_vecinos()

func _on_colision_vecino_2_area_entered(area):
	# Chequea si el area no es de tipo o si el edificio no está posicionado todavía o si el edificio con el que se está tocando areas no está posicionado todavia
	if not (area is BuildingTile) or not building_placed or not area.building_placed:
		return
	vecinos.append(area)
	calcular_total_vecinos()

func _on_colision_vecino_area_entered(area):
	# Chequea si el area no es de tipo o si el edificio no está posicionado todavía o si el edificio con el que se está tocando areas no está posicionado todavia
	if not (area is BuildingTile) or not building_placed or not area.building_placed:
		return
	vecinos.append(area)
	calcular_total_vecinos()
