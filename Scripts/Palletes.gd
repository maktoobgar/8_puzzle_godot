extends KinematicBody2D

export var x = 0
export var y = 0

export var px = 0
export var py = 0

var speed = 200

func _ready():
	pass

func _physics_process(delta):
	if (position.x > px):
		if position.x > px - 2 and position.x < px + 2:
			position.x = px
		else:
			move_and_slide(Vector2(-speed, 0), Vector2(0,-1))
	elif (position.x < px):
		if position.x > px - 2 and position.x < px + 2:
			position.x = px
		else:
			move_and_slide(Vector2(speed, 0), Vector2(0,-1))
	elif (position.y > py):
		if position.y > py - 2 and position.y < py + 2:
			position.y = py
		else:
			move_and_slide(Vector2(0, -speed), Vector2(0,-1))
	elif (position.y < py):
		if position.y > py - 2 and position.y < py + 2:
			position.y = py
		else:
			move_and_slide(Vector2(0, speed), Vector2(0,-1))
	else:
		move_and_slide(Vector2(0, 0), Vector2(0,-1))
