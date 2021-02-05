extends Node2D

var mouse: Area2D
var enter: KinematicBody2D
signal change_templates_of_class

func _ready():
	mouse = get_node("A2D_Mouse") 

func _input(event):
	if event.is_action_pressed("click"):
		if (get_node("./Control/Automate").disabled and get_node("./Control/Random").disabled):
			return
		if (enter):
			var x = enter.x 
			var y = enter.y
			enter.x = Globals.Black.x
			enter.px = Globals.Black.x * 72
			enter.y = Globals.Black.y
			enter.py = Globals.Black.y * 72
			Globals.Black.x = x
			Globals.Black.px = x * 72
			Globals.Black.y = y
			Globals.Black.py = y * 72
			Globals.Change_With = enter
			emit_signal("change_templates_of_class")
			enter = null
	if event is InputEventMouseMotion:
		mouse.position.x = event.position.x
		mouse.position.y = event.position.y

func _on_A2D_Mouse_body_entered(body):
	enter = body.get_parent() as KinematicBody2D

func _on_A2D_Mouse_body_exited(body):
	if (enter):
		if (body.get_parent().get_child(1).name == enter.get_child(1).name):
			enter = null
