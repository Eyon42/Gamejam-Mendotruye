class_name MainGameLoop
extends Node3D


@export var available_tile:PackedScene
@export var building_tiles:Array[PackedScene]
@export var snap_sounds: Array[AudioStreamWAV]

var _cam:Camera3D
var RAYCAST_LENGTH:float = 100
var tiles = Array()
var _current_tile: BuildingTile
var _selected_tile: Tile
var occupied_places = {"0":true}
var init = false
var sfx_player
var plop_sound = preload("res://assets/sound/drop.wav")
var game_music = preload("res://assets/sound/Maingame.wav")
var timer: Timer
var place_cooldown = false
var bad_end = false
var good_end = false

var good_scene = preload("res://scenes/ui/endings/good_ending.tscn")
var bad_scene = preload("res://scenes/ui/endings/bad_ending.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_cam = get_viewport().get_camera_3d()
	sfx_player = get_node("SFX")
	timer = get_node("Timer")
	setup()
	var music_player = get_node("MusicPlayer")
	music_player.set_volume_db(-5.0)
	Game.running = true
	pass # Replace with function body.

func setup():
	var tile:BuildingTile = building_tiles.pick_random().instantiate()
	self.add_child(tile)
	var zero_tile:Tile = available_tile.instantiate()
	add_tile(tile,zero_tile)
	start_drop()
	init = true
	
	
func play_snap_sound():
	var sound = snap_sounds.pick_random()
	sfx_player.stream = sound
	sfx_player.stop()
	sfx_player.set_volume_db(-10.0)
	sfx_player.play()
	
func play_plop_sound():
	sfx_player.stream = plop_sound
	sfx_player.stop()
	sfx_player.set_volume_db(0.0)
	sfx_player.play()

func _on_timer_timeout():
	place_cooldown = false

func add_tile(tile: BuildingTile, used_tile: Tile):
	place_cooldown = true
	timer.set_wait_time(1.0)
	timer.start()
	play_plop_sound()
	var pos = used_tile.position
	Game.placed_tiles += 1
	Game.speed_penalty = 0
	if (Game.placed_tiles == Game.total_spaces):
		good_end = true
	# print(str(placed_tiles) + "/" + str(total_spaces))
	
	# Lo agrego a los edificios globales
	Budget.array_edificios.append(tile)
	tile.building_placed = true
	tile.enable_lateral_collisions()
	
	used_tile.queue_free()
	tile.position = pos
	tile.visible = true
	# Build available tiles
	# top
	add_available_tile(Vector3(pos.x,pos.y,pos.z +1))
	# bottom
	add_available_tile(Vector3(pos.x,pos.y,pos.z -1))
	# left
	add_available_tile(Vector3(pos.x-1,pos.y,pos.z))
	# right
	add_available_tile(Vector3(pos.x+1,pos.y,pos.z))

func add_available_tile(pos):
	var key = str(pos.x + pos.z*100)
	if (!occupied_places.has(key)):
		if (abs(pos.x) > Game.grid_radius or abs(pos.z) > Game.grid_radius):
			return null
		var a_tile:Node3D = available_tile.instantiate()
		a_tile.position = pos
		self.add_child(a_tile)
		occupied_places[key] = true
		return a_tile

func start_drop():
	_current_tile = building_tiles.pick_random().instantiate()
	_current_tile.visible = false
	self.add_child(_current_tile)
	Game.current_building = _current_tile

func onTileHover(tile: Tile):
	_current_tile.visible = true
	_current_tile.position = tile.position
	_selected_tile = tile
	_selected_tile.visible = false

func offTileHover():
	if (_selected_tile != null):
		_current_tile.visible = false
		_selected_tile.visible = true
		_selected_tile = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if init:
		if good_end:
			self.queue_free()
			var scene = good_scene.instantiate()
			get_tree().root.add_child(scene)
			remove_child(sfx_player)
			remove_child(get_node("MusicPlayer"))
			Game.running = false
			self.queue_free()
		if bad_end:
			self.queue_free()
			var scene = bad_scene.instantiate()
			get_tree().root.add_child(scene)
			remove_child(sfx_player)
			remove_child(get_node("MusicPlayer"))
			Game.running = false
			self.queue_free()
		processMouse()
	
	if (Budget.money < 0):
		bad_end = true
	Game.speed_penalty += 0.01 + Game.speed_penalty / 100

func processMouse():
	var space_state = self.get_world_3d().direct_space_state
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	var origin:Vector3 = _cam.project_ray_origin(mouse_pos)
	var end:Vector3 = origin + _cam.project_ray_normal(mouse_pos) * RAYCAST_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, "000100".reverse().bin_to_int())
	query.collide_with_areas = true
	var rayResult:Dictionary = space_state.intersect_ray(query)
	if rayResult.size() > 0:
		if Input.is_action_just_pressed("left_click"):
			#if not place_cooldown:
			add_tile(_current_tile, rayResult.collider)
			start_drop()
		else: 
			if (rayResult.collider != _selected_tile):
				offTileHover()
				play_snap_sound()
				onTileHover(rayResult.collider)
	else:
		offTileHover()
