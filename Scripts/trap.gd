extends Spatial

func _ready():
	$"Trap/AnimationPlayer".play("close")
	
	
	pass # Replace with function body.


func _on_Area_body_entered(body):
	print(body)
	if body.is_in_group("trash"):
		body.dead()
