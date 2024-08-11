extends Node3D
@onready var border = $Border
@onready var border_2 = $Border2
@onready var border_3 = $Border3
@onready var border_4 = $Border4


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_building_tile_money_gained_changed(value):
	var material : StandardMaterial3D = StandardMaterial3D.new()
	if value > 0:
		material.albedo_color = Color(0.341, 1, 0.463)
		material.emission = Color(0.341, 1, 0.463)
	elif value < 0:
		
		material.albedo_color = Color(1, 0.34, 0.34)
		material.emission = Color(1, 0.34, 0.34)
	
	border.set_surface_override_material(0, material)
	border_2.set_surface_override_material(0, material)
	border_3.set_surface_override_material(0, material)
	border_4.set_surface_override_material(0, material)
