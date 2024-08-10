extends Node3D

@export var empty_tile:PackedScene
@export var available_tile:PackedScene
@export var building_tiles:Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	pass # Replace with function body.


func setup():
	var tile:Node3D = building_tiles.pick_random().instantiate()
	tile.position = Vector3(0,0,0)
	var a_tile:Node3D = available_tile.instantiate()
	a_tile.position = Vector3(1,0,0)
	self.add_child(tile)
	self.add_child(a_tile)
	print("ficha")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
