extends Area2D


export var door_path : String # this does nothing
var my_door

var bodies_in = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	my_door = get_parent().get_parent().get_node_or_null("Door")
	if my_door == null:
		my_door = get_parent().get_node_or_null("Door")
	if my_door == null:
		push_error("The button wasn't able to find the door! Please put the button inside an Entities node and the door either as a child of the Entities node or as a sibling of the Entities node!")
	am_i_pressed(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_body_entered(body):
	if body is TileMap:
		return
	bodies_in += 1
	am_i_pressed(false)


func _on_Button_body_exited(body):
	if body is TileMap:
		return
	bodies_in -= 1
	am_i_pressed(false)
	
	
func am_i_pressed(silent):
	if bodies_in > 0:
		$Button.play("Pressed")
		if not silent:
			$Pressed.play()
		my_door.open()
	else:
		$Button.play("Depressed")
		if not silent:
			$Depressed.play()
		my_door.close()
