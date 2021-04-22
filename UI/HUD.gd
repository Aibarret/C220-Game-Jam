extends Control

func _ready():
	var _time_changed = Global.connect("time_changed",self,"_on_time_changed")
	_on_time_changed()

func _on_time_changed():
	$Time.text = "Time: " + str(Global.time)

func _on_Timer_timeout():
	Global.change_time()
