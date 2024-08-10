extends Node3D


@export var available_tile:PackedScene
@export var building_tiles:Array[PackedScene]

var _cam:Camera3D
var RAYCAST_LENGTH:float = 100
var tiles = Array()
var _current_tile: BuildingTile
var _selected_tile: Tile


# Called when the node enters the scene tree for the first time.
func _ready():
	_cam = get_viewport().get_camera_3d()
	setup()
	pass # Replace with function body.

func setup():
	var tile:BuildingTile = building_tiles.pick_random().instantiate()
	self.add_child(tile)
	var zero_tile:Tile = building_tiles.pick_random().instantiate()
	add_tile(tile,zero_tile)
	start_drop()

func add_tile(tile: BuildingTile, used_tile: Tile,):
	var pos = used_tile.position
	print(pos)
	used_tile.queue_free()
	tile.position = pos
	tile.visible = true
	# Build available tiles
	# TODO: Check available
	# top
	add_available_tile(Vector3(pos.x,pos.y,pos.z +1))
	# bottom
	add_available_tile(Vector3(pos.x,pos.y,pos.z -1))
	# left
	add_available_tile(Vector3(pos.x-1,pos.y,pos.z))
	# right
	add_available_tile(Vector3(pos.x+1,pos.y,pos.z))
	pass

func add_available_tile(pos):
	print(pos)
	if (abs(pos.x) >2 or abs(pos.z) > 2):
		return null
	var a_tile:Node3D = available_tile.instantiate()
	a_tile.position = pos
	self.add_child(a_tile)
	print("Available added")
	return a_tile

func start_drop():
	_current_tile = building_tiles.pick_random().instantiate()
	_current_tile.visible = false
	self.add_child(_current_tile)

func onTileHover(tile: Tile):
	_current_tile.visible = true
	_current_tile.position = tile.position
	_selected_tile = tile
	_selected_tile.visible = false
	print("show selected")
	
	
func offTileHover():
	if (_selected_tile != null):
		_current_tile.visible = false
		_selected_tile.visible = true
		print("show selected")
		_selected_tile = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processMouse()

func processMouse():
	var space_state = self.get_world_3d().direct_space_state
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	var origin:Vector3 = _cam.project_ray_origin(mouse_pos)
	var end:Vector3 = origin + _cam.project_ray_normal(mouse_pos) * RAYCAST_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, "000100".reverse().bin_to_int())
	query.collide_with_areas = true
	var rayResult:Dictionary = space_state.intersect_ray(query)
	if rayResult.size() > 0:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			add_tile(_current_tile, rayResult.collider)
			start_drop()
		else: 
			if (rayResult.collider != _selected_tile):
				offTileHover()
				onTileHover(rayResult.collider)
	else:
		offTileHover()
