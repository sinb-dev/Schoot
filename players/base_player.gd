extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var playername = "";
var initiated: bool = false

#Called by Godot when player node enters tree, which is a it early
# so we trigger an event
func _enter_tree():
	set_multiplayer_authority(name.to_int())
	var game_node = get_tree().root.get_child(0)
	game_node.init_player(self)
	
# Used by Game node to setup the player
func init(name, x, y):
	playername = name
	$Playername.text = name
	position.x = x
	position.y = y
	initiated = true
	
func _physics_process(delta):
	if not is_multiplayer_authority():
		return;

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
