extends Node

@onready var timer = $Timer

var money : float = 30000

var array_edificios : Array
var current_rate = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.running:
		money += recolectar_money() - (Game.speed_penalty / 5)**1.25 - Game.placed_tiles
	else:
		array_edificios = Array()
		Game.placed_tiles = 0
		Game.speed_penalty = 0
		money = 30000

func recolectar_money():
	var suma := 0.0
	#TODO: esto como que a veces no suma bien no se porque xd
	for edificio : BuildingTile in array_edificios:
		suma += edificio.money_gain
	current_rate = suma
	return suma
	
