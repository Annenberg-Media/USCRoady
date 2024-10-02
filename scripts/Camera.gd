extends Spatial

# Player node path
var player: NodePath = "../Player" 

# Speed of the camera
var follow_speed: float = 5.0

func _process(delta):
	var player_node = get_node(player)
	if translation.z > player_node.translation.z:
		translation.z = lerp(translation.z, player_node.translation.z, delta * follow_speed)
