extends Node3D


@export var available_tile:PackedScene
@export var building_tiles:Array[PackedScene]

var _cam:Camera3D
var RAYCAST_LENGTH:float = 100
var tiles = Array()
var _current_tile: BuildingTile

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
	var a_tile:Node3D = available_tile.instantiate()
	a_tile.position = pos
	self.add_child(a_tile)
	print("Available added")
	return a_tile

func start_drop():
	_current_tile = building_tiles.pick_random().instantiate()
	_current_tile.visible = false
	self.add_child(_current_tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		processHover()

func processHover():
	var space_state = self.get_world_3d().direct_space_state
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	var origin:Vector3 = _cam.project_ray_origin(mouse_pos)
	var end:Vector3 = origin + _cam.project_ray_normal(mouse_pos) * RAYCAST_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, "100111".reverse().bin_to_int())
	query.collide_with_areas = true
	var rayResult:Dictionary = space_state.intersect_ray(query)
	if rayResult.size() > 0:
		print(_current_tile)
		add_tile(_current_tile, rayResult.collider)
		start_drop()
		#var co:CollisionObject3D = rayResult.get("collider")
		#if co.get_groups()[0] == "grid_empty":
		if true:
			#_is_valid_location = true
			#_last_valid_location = Vector3(co.global_position.x, 0.2, co.global_position.z)
			#_draggable.global_position = _last_valid_location
			#clear_child_mesh_error(_draggable)
			pass
		else:
			#_draggable.visible = true
			#_draggable.global_position = Vector3(co.global_position.x, 0.2, co.global_position.z)
			#_is_valid_location = false
			#set_child_mesh_error(_draggable)
			pass
	else:
		#_draggable.visible = false
		pass
