extends Node

var time = 0
var level = 1

signal time_changed

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	if level == 1:
		time = 10
	

func _unhandled_input(event):
	if event.is_action_pressed("quit"): 
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			var p = get_tree().paused
			if p:
				menu.hide()
				get_tree().paused = false
			else:
				menu.show()
				get_tree().paused = true


func change_time():
	if level == 1:
		time -= 1
		if time <= 0:
			time = 0
			get_tree().change_scene("res://UI/Main Menu.tscn")
	else:
		time += 1
	emit_signal("time_changed")

