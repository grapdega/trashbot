extends Spatial

var time = 0
var delay=rand_range(0.0,5.0)
export var norand = false

func _process(delta):
	if time > delay or norand:
		$"Trap/AnimationPlayer".play("close")
	else:
		time+=delta
	
	pass # Replace with function body.


func _on_Area_body_entered(body):
	print(body)
	if body.is_in_group("trash"):
		body.dead()
