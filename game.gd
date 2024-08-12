extends Node

var grid_radius = 4
var total_spaces = (grid_radius * 2 + 1)**2
var placed_tiles = 0
var current_building: BuildingTile
var speed_penalty = 0
var running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello World")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
