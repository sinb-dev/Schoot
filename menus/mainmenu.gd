extends Control
signal join
signal host

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_join_button_pressed():
	join.emit($TxtUsername.text);

func _on_host_button_pressed():
	host.emit($TxtUsername.text);
