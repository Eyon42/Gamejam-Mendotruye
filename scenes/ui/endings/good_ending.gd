extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	self.queue_free()
	var scene = load("res://scenes/main.tscn").instantiate()
	get_tree().root.add_child(scene)
	var audio_node = get_node("AudioStreamPlayer")
	remove_child(audio_node)
	self.queue_free()
	
