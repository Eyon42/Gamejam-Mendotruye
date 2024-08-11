extends Node

@onready var timer = $Timer

var money : float = 0

var array_edificios : Array
var current_rate = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func recolectar_money():
	var suma := 0.0
	#TODO: esto como que a veces no suma bien no se porque xd
	for edificio : BuildingTile in array_edificios:
		suma += edificio.money_gain
<<<<<<< HEAD
	#print("")
	current_rate = suma
=======
>>>>>>> 20bc000f9b0ace6b9c2c4ea5572dddd73ca6c3c2
	return suma

func _on_timer_timeout():
	money += recolectar_money()
