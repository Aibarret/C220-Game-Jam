extends Area2D

onready var Global = get_node("/root/Global")

export var is_orb = false

var open = true

func _ready():
	$Sprite.visible = not is_orb
	$AnimatedSprite.visible = is_orb

func _on_Door_body_entered(body):
	if body.name == "Player" and open:
		Global.next_level_alternate()


func open():
	modulate = Color(1.0, 1.0, 1.0, 1.0)
	open = true
	
func close():
	modulate = Color(0.4, 0.4, 0.4, 1.0)
	open = false
