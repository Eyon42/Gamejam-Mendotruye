class_name BuildingTile
extends Tile

enum Category {
	RESIDENCIAL,
	RECREATIVO,
	INDUSTRIAL,
	COMERCIAL
}

@export var category: Category

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
