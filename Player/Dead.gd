extends "res://StateMachine/StateMachineState.gd"

export var Tombstone : PackedScene



func start():
	myEnt.velocity = Vector2.ZERO
	var tombstone = Tombstone.instance()
	myEnt.get_parent().get_parent().get_node_or_null("Entities").add_child(tombstone)
	tombstone.global_position = myEnt.global_position
	print(tombstone.global_position)

func physics_process(_delta):
	myEnt.queue_free()
