extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mute =false
# Called when the node enters the scene tree for the first time.
func _ready():
	ui_update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Lvl/lvl-1.tscn")


func _on_Button3_pressed():
	get_tree().quit()


func _on_Button2_pressed():
	mute=!mute
	ui_update()
func ui_update():
	if mute:
		$"/root/Background".get_node("AudioStreamPlayer2D").stop()
		$Control/PanelContainer/Button2.text="Unmute"
	else:
		$"/root/Background".get_node("AudioStreamPlayer2D").play()
		$Control/PanelContainer/Button2.text="Mute"
