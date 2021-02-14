extends Button

var isrun = false
var cmd=''
var curlvl=1
onready var trash = get_parent().get_parent().get_parent().get_node("Trash")
func _ready():
	pass # Replace with function body.

func _process(delta):
	if len(cmd) > trash.curpos:
		get_parent().get_node("cur").text=cmd[trash.curpos]
	if trash.lvldone:
		text='Next'
		ui_update()
		


func _on_play():
	if not isrun:
		if len(cmd) == 0 and get_parent().get_parent().get_parent().get_node("cmd"):
			cmd=get_parent().get_parent().get_parent().get_node("cmd").text
		trash.cmd=cmd
		trash.play=true
		text='Stop'
		ui_update()
	else:
		get_parent().get_parent().get_parent().get_tree().reload_current_scene()
		text='Start'
	if trash.lvldone:
		next_level()
	isrun=!isrun


func _on_go_pressed():
	cmd+='w'
	ui_update()
	
func ui_update():
	get_parent().get_node("Label").text=cmd


func _on_left_pressed():
	cmd+='a'
	ui_update()


func _on_right_pressed():
	cmd+='d'
	ui_update()


func _on_idle_pressed():
	cmd+='s'
	ui_update()


func _on_clear_pressed():
	if cmd=='':
		next_level()
	cmd=''
	ui_update()


func next_level():
	curlvl+=1
	get_parent().get_parent().get_parent().get_tree().change_scene("res://Lvl/lvl-"+str(curlvl)+".tscn")