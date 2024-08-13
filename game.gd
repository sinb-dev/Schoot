extends Node
const PORT: int = 9000
var peer = ENetMultiplayerPeer.new();
var local_player = {
	name = "Unnamed"
}
@export var player_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func join():
	pass
	
func host():
	pass

func _on_mainmenu_host(playername):
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	local_player.name = playername
	$Mainmenu.visible = false

func _on_mainmenu_join(playername):
	peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = peer
	local_player.name = playername;
	$Mainmenu.visible = false

# Called when another player connects or when you host
func _add_player(id: int = 1):
	var new_player = player_scene.instantiate();
	new_player.name = str(id);
	call_deferred("add_child", new_player)
	
func init_player(player):
	if not player.is_multiplayer_authority():
		return;
	player.init(local_player.name, 0, 200);
	
