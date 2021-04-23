extends Control


func _ready():
	pass 


func _on_Play_pressed():
	Global.next_level()

func _on_Quit_pressed():
	get_tree().quit()
