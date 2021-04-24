extends KinematicBody2D

onready var variants = [load("res://Player/Placeholder.tres"),
						load("res://Player/Arnold.tres"),
						load("res://Player/Mike.tres"),
						load("res://Player/Griffin.tres")]

onready var Global = get_node("/root/Global")

onready var SM = $StateMachine
onready var tilemap = get_parent().get_parent().get_node_or_null("TileMap")

export var player_name : String
export var variant : int
export var fate : String

var active = true

var velocity = Vector2(0.0, 0.0)
var normal_gravity = 1550.0
var jump_gravity = 900.0
var acceleration = Vector2(0.0, normal_gravity)
var move_speed = 300
var jump_speed = -560
var run_and_jump_speed = -640
var jump_released = true
var flipH = false
var default_coyote_time = 4.0 / 60.0 # seconds
var coyote_time = 0.0
var dead_timer = 0.0
var respawn_time = 1.0

var initial_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.frames = variants[variant]
	if variant == 0:
		$AnimatedSprite.scale = Vector2(5,5)
	initial_position = position
	$Name.text = player_name
	add_to_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.flip_h = flipH
	#$AnimatedSprite.offset.x = 1 if flipH else -1
	#if velocity.y > 0 and $AnimatedSprite.animation == "Jumping":
	#	$AnimatedSprite.play("Falling_Start")

func _physics_process(delta):
	if SM.state_name == "Dead":
		#$CollisionPolygon2D.disabled = true
		dead_timer += delta
		if dead_timer > respawn_time:
			respawn()
		return
	if Input.is_action_just_released("up"):
		jump_released = true
	velocity += acceleration * delta
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/3, false)
	handle_direction(get_input_pressed("left"), get_input_pressed("right"))
	if is_on_wall():
		velocity.x = 0
	coyote_time -= delta # delta because it's in seconds
	
	# this is how it interacts with the tilemap, since we don't really have any tiles yet, this doesn't mean anything
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider == tilemap:
			# I test each collision at 4 different points just in case if it's on a bad edge or corner
			for x in [-1, 1]:
				for y in [-1, 1]:
					var tile = get_tile_at_pos(collision.position + Vector2(x * 0.1, y * 0.1))
					#if tile == 14 or tile == 15: # steven tile
					#	die()
	var tile = get_tile_at_pos(position)
	
	match tile:
		7: # spikes
			die()
	
	
func get_tile_at_pos(pos):
	var input_position = pos - tilemap.position
	input_position /= tilemap.scale.x
	var grid_position = tilemap.world_to_map(input_position)
	var tile = tilemap.get_cellv(grid_position)
	return tile
	
func set_tile_at_pos(pos, tile):
	var input_position = pos - tilemap.position
	input_position /= tilemap.scale.x
	var grid_position = tilemap.world_to_map(input_position)
	tilemap.set_cellv(grid_position, tile)

func die():
	SM.set_state("Dead")
	print(player_name + " " + fate)
	$Die.play()
	$CollisionPolygon2D.disabled = true
	
func respawn():
	position = initial_position
	SM.set_state("Idle")
	visible = true
	dead_timer = 0.0
	$Respawn.play()
	$CollisionPolygon2D.disabled = false
	
func set_animation(anim):
	if $AnimatedSprite.animation != anim:
		$AnimatedSprite.play(anim)

func _on_AnimatedSprite_animation_finished():
	pass

func handle_direction(isleft, isright):
	if isleft != isright:
		flipH = isleft

func get_input_pressed(control):
	if active:
		return Input.is_action_pressed(control)
	else:
		return false

func get_input_just_pressed(control):
	if active:
		return Input.is_action_just_pressed(control)
	else:
		return false
