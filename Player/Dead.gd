extends "res://StateMachine/StateMachineState.gd"

export var Tombstone : PackedScene



func start():
	myEnt.velocity = Vector2.ZERO
	var tombstone = Tombstone.instance()
	tombstone.global_position = myEnt.global_position

func physics_process(_delta):
	pass
