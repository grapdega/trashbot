extends KinematicBody


var i=0
export var speed = 1.6
var time = 4
func _process(delta):
	var posx=0
	var posy=1
	time-=delta
	print(time)
	if i <  PI/2:
		i+=delta
		rotate_y(delta)
	else:
		posx=1
		posy=0
	if time < 0:
		posx=0
		posy=0
		$"t-pose/trash/AnimationPlayer".play("Idle")
	else:
		$"t-pose/trash/AnimationPlayer".play("animWalking")

	var vel = Vector3(1*speed*posx,0,1*speed*posy)
	move_and_slide(vel)
	
