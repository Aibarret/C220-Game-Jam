extends Node

var time = 10
var level = 0

var level_list = [
	"res://UI/Main Menu.tscn", # 0
	"res://Levels/TestLevelA.tscn", # 1
	"res://Levels/TestLevelB.tscn", # 2
	"res://Levels/TestLevelC.tscn", #3
	"res://Levels/TestLevelD.tscn" #4
]

var level_list_alternate = [
	"res://UI/Main Menu.tscn", # 0
	"res://Levels/TestLevelA.tscn", # 1
	"res://Levels/TestLevelBAlternate.tscn", # 2
	"res://Levels/TestLevelCAlternate.tscn", #3
	"res://Levels/TestLevelDAlternate.tscn" #4
]

signal time_changed

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	if level == 1:
		time = 30
	

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
	time -= 1
	if time <= 0:
		next_level()
	emit_signal("time_changed")
	
func next_level():
	level += 1
	if level < level_list.size() and level >= 0:
		time = 30
		get_tree().change_scene(level_list[level])
	if level >= level_list.size():
		level = 0
		get_tree().change_scene(level_list[level])

func next_level_alternate():
	level += 1
	if level < level_list_alternate.size() and level >= 0:
		time += 30
		get_tree().change_scene(level_list_alternate[level])
	if level >= level_list_alternate.size():
		level = 0
		get_tree().change_scene(level_list_alternate[level])
