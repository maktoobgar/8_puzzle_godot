extends Control

var Palletes: Array
var Pallete_Place: Pallete_Place_Class
var Next_Steps: Array
var Previous_Steps: Array
var Solved = true
var Auto_Timer: Timer

class Pallete_Place_Class:
	var what = []
	var pattern = []
	var blackx = 0
	var blacky = 0
	
	func _init():
		for i in range(0, 3):
			what.append([])
			for j in range(0, 3):
				what[i].append(0)
	
	func allow(var x, var y):
		if what[x][y]:
			return false
		return true
	
	func set_pallete(var pallete, var x, var y):
		what[x][y] = pallete
		if what[x][y].get_child(1).name == "B":
			blackx = x
			blacky = y
	
	func get_pallete(var x, var y):
		return what[x][y]
	
	func set_pattern():
		pattern = ""
		for i in range(0, 3):
			for j in range(0, 3):
				pattern += what[i][j].get_child(1).name
				
	func get_pattern():
		return pattern

func _ready():
	for i in range(0, 9):
		Palletes.append(0)
	Auto_Timer = get_node("../Auto_Timer")
	Pallete_Place = Pallete_Place_Class.new()
	var _1 = get_node("../Pallete/KB2D_1")
	var _2 = get_node("../Pallete/KB2D_2")
	var _3 = get_node("../Pallete/KB2D_3")
	var _4 = get_node("../Pallete/KB2D_4")
	var _5 = get_node("../Pallete/KB2D_5")
	var _6 = get_node("../Pallete/KB2D_6")
	var _7 = get_node("../Pallete/KB2D_7")
	var _8 = get_node("../Pallete/KB2D_8")
	var _B = get_node("../Pallete/KB2D_B")
	Palletes[0] = _1
	Palletes[1] = _2
	Palletes[2] = _3
	Palletes[3] = _8
	Palletes[4] = _B
	Palletes[5] = _4
	Palletes[6] = _7
	Palletes[7] = _6
	Palletes[8] = _5
	Globals.Black = _B
	var k = 0
	for j in range(0, 3):
		for i in range(0, 3):
			Pallete_Place.set_pallete(Palletes[k], j, i)
			k = k + 1
	Pallete_Place.set_pattern()

func _on_Random_button_up():
	Pallete_Place = Pallete_Place_Class.new()
	for i in range(0, 9):
		while (true):
			var rand1 = randi() % 3
			var rand2 = randi() % 3
			if (Pallete_Place.allow(rand2, rand1)):
				Pallete_Place.set_pallete(Palletes[i], rand2, rand1)
				Palletes[i].x = rand1
				Palletes[i].px = rand1 * 72
				Palletes[i].y = rand2
				Palletes[i].py = rand2 * 72
				break
	Pallete_Place.set_pattern()
	Solved = false
	left_pannel(false)

func _on_Reset_button_up():
	var k = 0
	for i in range(0, 3):
		for j in range(0, 3):
			Pallete_Place.set_pallete(Palletes[k], i, j)
			Palletes[k].x = j
			Palletes[k].px = j * 72
			Palletes[k].y = i
			Palletes[k].py = i * 72
			k = k + 1
	Pallete_Place.set_pattern()
	Solved = true
	left_pannel(false)

func _on_Exit_button_up():
	get_tree().quit()

func callback_findpath(var data):
	var pallete = data[0]
	var path = data[1]
	var previous_move = data[2]
	if (pallete.get_pattern() == "1238B4765"):
		Solved = true
		Next_Steps = path
		print(path)
		left_pannel(true)
		var i = 0
		var congrate = get_node("../Congrates")
		congrate.play("Congrates")
		congrate.frame = 0
		return
	if (!Solved):
		var p1 = []
		var p2 = []
		var p3 = []
		var p4 = []
		var move_1 = null
		var move_2 = null
		var move_3 = null
		var move_4 = null
		var first = false
		var second = false
		var third = false
		var fourth = false
		var pallete1 = Pallete_Place_Class.new()
		var pallete2 = Pallete_Place_Class.new()
		var pallete3 = Pallete_Place_Class.new()
		var pallete4 = Pallete_Place_Class.new()
		for item in path:
			p1.append(item)
			p2.append(item)
			p3.append(item)
			p4.append(item)
		for i in range(0, 3):
			for j in range(0, 3):
				pallete1.set_pallete(pallete.get_pallete(i, j), i, j)
				pallete2.set_pallete(pallete.get_pallete(i, j), i, j)
				pallete3.set_pallete(pallete.get_pallete(i, j), i, j)
				pallete4.set_pallete(pallete.get_pallete(i, j), i, j)
		pallete1.set_pattern()
		pallete2.set_pattern()
		pallete3.set_pattern()
		pallete4.set_pattern()
		if (pallete.blackx + 1 <= 2 and pallete1.get_pallete(pallete.blackx + 1, pallete.blacky).get_child(1).name != previous_move.back()):
			move_1 = pallete1.get_pallete(pallete.blackx + 1, pallete.blacky).get_child(1).name
			var blackx = pallete.blackx
			var blacky = pallete.blacky
			var temp = pallete1.get_pallete(blackx + 1, blacky)
			p1.append(temp.get_child(1).name)
			pallete1.set_pallete(pallete1.get_pallete(blackx, blacky), blackx + 1, blacky)
			pallete1.set_pallete(temp, blackx, blacky)
			pallete1.set_pattern()
			first = true
		if(pallete.blackx - 1 >= 0 and pallete2.get_pallete(pallete.blackx - 1, pallete.blacky).get_child(1).name != previous_move.back()):
			move_2 = pallete2.get_pallete(pallete.blackx - 1, pallete.blacky).get_child(1).name
			var blackx = pallete.blackx
			var blacky = pallete.blacky
			var temp = pallete2.get_pallete(blackx - 1, blacky)
			p2.append(temp.get_child(1).name)
			pallete2.set_pallete(pallete2.get_pallete(blackx, blacky), blackx - 1, blacky)
			pallete2.set_pallete(temp, blackx, blacky)
			pallete2.set_pattern()
			second = true
		if(pallete.blacky + 1 <= 2 and pallete3.get_pallete(pallete.blackx, pallete.blacky + 1).get_child(1).name != previous_move.back()):
			move_3 = pallete3.get_pallete(pallete.blackx, pallete.blacky + 1).get_child(1).name
			var blackx = pallete.blackx
			var blacky = pallete.blacky
			var temp = pallete3.get_pallete(blackx, blacky + 1)
			p3.append(temp.get_child(1).name)
			pallete3.set_pallete(pallete3.get_pallete(blackx, blacky), blackx, blacky + 1)
			pallete3.set_pallete(temp, blackx, blacky)
			pallete3.set_pattern()
			third = true
		if(pallete.blacky - 1 >= 0 and pallete4.get_pallete(pallete.blackx, pallete.blacky - 1).get_child(1).name != previous_move.back()):
			move_4 = pallete4.get_pallete(pallete.blackx, pallete.blacky - 1).get_child(1).name
			var blackx = pallete.blackx
			var blacky = pallete.blacky
			var temp = pallete4.get_pallete(blackx, blacky - 1)
			p4.append(temp.get_child(1).name)
			pallete4.set_pallete(pallete4.get_pallete(blackx, blacky), blackx, blacky - 1)
			pallete4.set_pallete(temp, blackx, blacky)
			pallete4.set_pattern()
			fourth = true
		if (len(path) > 20):
			return
		if (first):
			if (!Solved):
				previous_move.push_back(move_1)
				callback_findpath([pallete1, p1, previous_move])
				previous_move.pop_back()
		if (second):
			if (!Solved):
				previous_move.push_back(move_2)
				callback_findpath([pallete2, p2, previous_move])
				previous_move.pop_back()
		if (third):
			if (!Solved):
				previous_move.push_back(move_3)
				callback_findpath([pallete3, p3, previous_move])
				previous_move.pop_back()
		if (fourth):
			if (!Solved):
				previous_move.push_back(move_4)
				callback_findpath([pallete4, p4, previous_move])
				previous_move.pop_back()

func left_pannel(var enable):
	if enable:
		get_node("./Step+").disabled = false
		get_node("./Step-").disabled = false
		get_node("./Automate").disabled = false
	if !enable:
		get_node("./Step+").disabled = true
		get_node("./Step-").disabled = true
		get_node("./Automate").disabled = true
		Next_Steps = []
		Previous_Steps = []

func pannels(enable):
	if enable:
		get_node("./Step+").disabled = false
		get_node("./Step-").disabled = false
		get_node("./Automate").disabled = false
		get_node("./Reset").disabled = false
		get_node("./Random").disabled = false
		get_node("./Path_Finding").disabled = false
	if !enable:
		get_node("./Step+").disabled = true
		get_node("./Step-").disabled = true
		get_node("./Automate").disabled = true
		get_node("./Reset").disabled = true
		get_node("./Random").disabled = true
		get_node("./Path_Finding").disabled = true

func _on_Path_Finding_button_up():
	var node_path = get_node("Path_Finding")
	node_path.disabled = true
	left_pannel(false)
	callback_findpath([Pallete_Place, [], []])
	node_path.disabled = false

func _on_Step_P_button_up():
	var first = Next_Steps.pop_front()
	if (first):
		Previous_Steps.insert(0, first)
		var first_obj = get_node("../Pallete/KB2D_" + first)
		var x = first_obj.x 
		var y = first_obj.y
		first_obj.x = Globals.Black.x
		first_obj.px = Globals.Black.x * 72
		first_obj.y = Globals.Black.y
		first_obj.py = Globals.Black.y * 72
		Globals.Black.x = x
		Globals.Black.px = x * 72
		Globals.Black.y = y
		Globals.Black.py = y * 72
		Pallete_Place.set_pallete(first_obj, first_obj.y, first_obj.x)
		Pallete_Place.set_pallete(Globals.Black, Globals.Black.y, Globals.Black.x)
		Pallete_Place.set_pattern()
		Globals.Change_With = null
		if (Pallete_Place.get_pattern() == "1238B4765"):
			Solved = true
			Auto_Timer.stop()
			pannels(true)
		else:
			Solved = false

func _on_Step_M_button_up():
	var first = Previous_Steps.pop_front()
	if (first):
		Next_Steps.insert(0, first)
		var first_obj = get_node("../Pallete/KB2D_" + first)
		var x = first_obj.x 
		var y = first_obj.y
		first_obj.x = Globals.Black.x
		first_obj.px = Globals.Black.x * 72
		first_obj.y = Globals.Black.y
		first_obj.py = Globals.Black.y * 72
		Globals.Black.x = x
		Globals.Black.px = x * 72
		Globals.Black.y = y
		Globals.Black.py = y * 72
		Pallete_Place.set_pallete(first_obj, first_obj.y, first_obj.x)
		Pallete_Place.set_pallete(Globals.Black, Globals.Black.y, Globals.Black.x)
		Pallete_Place.set_pattern()
		Globals.Change_With = null
		if (Pallete_Place.get_pattern() == "1238B4765"):
			Solved = true
		else:
			Solved = false

func _on_8_Puzzle_Game_change_templates_of_class():
	left_pannel(false)
	Pallete_Place.set_pallete(Globals.Change_With, Globals.Change_With.y, Globals.Change_With.x)
	Pallete_Place.set_pallete(Globals.Black, Globals.Black.y, Globals.Black.x)
	Pallete_Place.set_pattern()
	Globals.Change_With = null
	if (Pallete_Place.get_pattern() == "1238B4765"):
		Solved = true
	else:
		Solved = false

func _on_Auto_Timer_timeout():
	_on_Step_P_button_up()

func _on_Automate_button_up():
	if (Pallete_Place.get_pattern() != "1238B4765"):
		Auto_Timer.start()
		pannels(false)
