extends Area2D

onready var Global = get_node("/root/Global")

func _ready():
	pass 

func _on_Door_body_entered(body):
	if body.name == "Player":
		Global.next_level_alternate()
