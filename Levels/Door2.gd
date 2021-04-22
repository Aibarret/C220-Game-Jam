extends Area2D

func _ready():
	pass 

func _on_Door2_body_entered(body):
	if body.name == "Player":
		Global.level = 1
		var _s = get_tree().change_scene("res://UI/Main Menu.tscn")
