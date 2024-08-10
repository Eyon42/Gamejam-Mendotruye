extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	GameManager.newGame.rpc()
	deleteSelf.rpc()

@rpc("any_peer", "call_local")	
func deleteSelf():
	self.queue_free()
	
