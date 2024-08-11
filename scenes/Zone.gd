extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cat = ""
	match (Game.current_building.category):
			Types.Category.RESIDENCIAL:
				cat = "Residencial"
			Types.Category.INDUSTRIAL:
				cat = "Industrial"
			Types.Category.RECREATIVO:
				cat = "Recreativo"
			Types.Category.COMERCIAL:
				cat = "Comercial"
		
		
	text = "Zona: " + cat
