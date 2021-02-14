extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mute=false

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Input.is_action_just_pressed('mute'):
		mute=!mute
		if mute:
			$AudioStreamPlayer2D.play()
		else : 
			$AudioStreamPlayer2D.stop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
