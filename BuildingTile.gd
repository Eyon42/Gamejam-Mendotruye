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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _calculate_money_gain(categoria: Category , categoria_vecina: Category):
	var money_changed 
	if categoria == Category.RESIDENCIAL:
		if categoria_vecina == Category.RECREATIVO:
			money_changed = aumento_grande
		if categoria_vecina == Category.INDUSTRIAL:
			money_changed = resta_grande
		if categoria_vecina == Category.COMERCIAL:
			money_changed = aumento	
	
	if categoria == Category.INDUSTRIAL:
		if categoria_vecina == Category.RECREATIVO:
			money_changed = resta_grande
		if categoria_vecina == Category.RESIDENCIAL:
			money_changed = resta_grande
		if categoria_vecina == Category.COMERCIAL:
			money_changed = aumento
	
	if categoria == Category.COMERCIAL:
		if categoria_vecina == Category.RECREATIVO:
			money_changed = aumento_grande
		if categoria_vecina == Category.INDUSTRIAL:
			money_changed = aumento
		if categoria_vecina == Category.RESIDENCIAL:
			money_changed = aumento
			
	if categoria == Category.RECREATIVO:
		if categoria_vecina == Category.COMERCIAL:
			money_changed = aumento_grande
		if categoria_vecina == Category.INDUSTRIAL:
			money_changed = resta_grande
		if categoria_vecina == Category.RESIDENCIAL:
			money_changed = aumento_grande
			
	return money_changed
