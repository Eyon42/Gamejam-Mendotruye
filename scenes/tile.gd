class_name Tile
extends Area3D

signal money_gained_changed(value)

@export var money_gain : float = 0:
	set(value):
		money_gain = value
		money_gained_changed.emit(value)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

