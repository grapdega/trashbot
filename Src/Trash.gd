extends KinematicBody


var der=0
export var speed = 1.6
export var delay = 3.2
export var cmd = ""
var curpos=0
var time = 0
var d = 1.0
var left=false
var rigth=false
var walk=false
var idle=false
var interrupt=false
var v = Vector2.ZERO
export var play = false
var lvldone=false
var v2 = v
func _ready():
	add_to_group("trash",false)
	var rt = rotation.y
	print(rt,' ',PI/2)
	if int(rt*100) == 0:
		v=Vector2(0,-1)	
	if int(rt*100) == int(PI*50):
		v=Vector2(-1,0)
	if int(rt*100) == -1*int(PI*100):
		v=Vector2(0,1)
	if int(rt*100) == -1*int(PI*50):
		v=Vector2(1,0)
	v2=v
	#cmd='s'+cmd
func _process(delta):
	if play:
		d=delta
		time+=d
		cmd_process()
		v=be_idle(v)
		v=be_walk(v)
		v=turn_right(v.x,v.y)
		v=turn_left(v.x,v.y)
		
		var vel = vec2vel(v)
		move_and_slide(vel)

func cmd_process():
	walk=false
	idle=false
	if curpos >= len(cmd):
		idle=true
	elif cmd[curpos] == "w":
		walk=true
	elif cmd[curpos] == "u":
		left = true
	elif cmd[curpos] == "o":
		idle=true
	elif cmd[curpos] == "v":
		rigth = true
	if time > delay:
		time=0
		print(v.x,' ',v.y)
		curpos+=1
	

func vec2vel(v):
	if v:
		return Vector3(1*speed*v.x,0,1*speed*v.y)
	else:
		return Vector3(0,0,0)


func turn_left(i,j):
	if not left:
		return Vector2(i,j)
	if der <  PI/2:
		der+=d
		#rotate_y(d)
		if not interrupt:
			interrupt=true
			$trash/AnimationPlayer.play("Left Turn-loop")
			time=0
		v2=Vector2(i,j)
		return Vector2(0,0)
	else:
		interrupt=false
		rotate_y(PI/2)
		var k = 0
		var l = 0
		der=0
		curpos+=1
		left=false
		if i==0 && j == 1:
			return Vector2(1,0)
		if i==0 && j == -1:
				return Vector2(-1,0)
		if i==1 && j == 0:
			return Vector2(0,-1)
		if i==-1 && j == 0:
			return Vector2(0,1)
		if i==0 and j == 0:
			return v2
		
			
func turn_right(i,j):
	if not rigth: 
		return Vector2(i,j)
	if der <  PI/2:
		der+=d
		#rotate_y(-1*d)
		if not interrupt:
			interrupt=true
			$trash/AnimationPlayer.play("Right Turn-loop")
			time=0
		v2=Vector2(i,j)
		return Vector2(0,0)
	else:
		interrupt=false
		rotate_y(-1*PI/2)
		var k = 0
		var l = 0
		der=0
		curpos+=1
		rigth=false
		if i==0 and j == 1:
			return Vector2(-1,0)
		if i==0 and j == -1:
			return Vector2(1,0)
		if i==1 and j == 0:
			return Vector2(0,1)
		if i==-1 and j == 0:
			return Vector2(0,-1)
		if i==0 and j == 0:
				return v2


func be_idle(v):
	if v2.x != 0 or v2.y != 0:
		v=v2
		v2=Vector2(0,0)
		
	if not idle:
		return v
	if v.x != 0 or v.y != 0:
		v2=v
		v=Vector2(0,0)
	$"trash/AnimationPlayer".play("Idle-loop")
	return v

func be_walk(v):
	if not walk:
		return v
	$"trash/AnimationPlayer".play("Walk-loop")
	return v
	
func dead():
	if play:
		$"trash/AnimationPlayer".play("Dead-loop")
		play=false
