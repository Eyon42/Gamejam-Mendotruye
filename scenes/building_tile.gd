class_name BuildingTile
extends Tile

enum Category {
	RESIDENCIAL,
	RECREATIVO,
	INDUSTRIAL,
	COMERCIAL
}
@export var aumento : float = 50
@export var aumento_grande : float = 100
@export var resta : float = -50
@export var resta_grande : float = -100

@export var category: Category

var vecinos : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Calcula plata gana segun con respecto a sus vecinos
func _calculate_money_gain(categoria_vecina: Category):
	var money_changed 
	if category == Category.RESIDENCIAL:
		if categoria_vecina == Category.RECREATIVO:
			money_changed = aumento_grande
		if categoria_vecina == Category.INDUSTRIAL:
			money_changed = resta_grande
		if categoria_vecina == Category.COMERCIAL:
			money_changed = aumento	
	
	if category == Category.INDUSTRIAL:
		if categoria_vecina == Category.RECREATIVO:
			money_changed = resta_grande
		if categoria_vecina == Category.RESIDENCIAL:
			money_changed = resta_grande
		if categoria_vecina == Category.COMERCIAL:
			money_changed = aumento
	
	if category == Category.COMERCIAL:
		if categoria_vecina == Category.RECREATIVO:
			money_changed = aumento_grande
		if categoria_vecina == Category.INDUSTRIAL:
			money_changed = aumento
		if categoria_vecina == Category.RESIDENCIAL:
			money_changed = aumento
			
	if category == Category.RECREATIVO:
		if categoria_vecina == Category.COMERCIAL:
			money_changed = aumento_grande
		if categoria_vecina == Category.INDUSTRIAL:
			money_changed = resta_grande
		if categoria_vecina == Category.RESIDENCIAL:
			money_changed = aumento_grande
			
	return money_changed

func calcular_total_vecinos():
	var suma = 0
	for vecino : BuildingTile in vecinos:
		suma += _calculate_money_gain(vecino.category)
	
	money_gain = suma


func _on_colision_vecino_4_area_entered(area : BuildingTile):
	if area == null:
		return
	
	vecinos.append(area)
	calcular_total_vecinos()

func _on_colision_vecino_3_area_entered(area : BuildingTile):
	if area == null:
		return
	
	vecinos.append(area)
	calcular_total_vecinos()

func _on_colision_vecino_2_area_entered(area : BuildingTile):
	if area == null:
		return
	
	vecinos.append(area)
	calcular_total_vecinos()

func _on_colision_vecino_area_entered(area : BuildingTile):
	if area == null:
		return
	
	vecinos.append(area)
	calcular_total_vecinos()
