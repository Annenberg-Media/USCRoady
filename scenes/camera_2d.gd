extends Camera2D

var screen_limits = Rect2(Vector2(0, 0), Vector2(1024, 768)) # Example screen limits
var vertical_offset = 200 

func _ready():
	make_current()

func _process(delta):
	var player_position = get_parent().get_node("Player").position

	position.x = player_position.x
	position.y = player_position.y - vertical_offset

	position.x = clamp(position.x, screen_limits.position.x, screen_limits.position.x + screen_limits.size.x)
	position.y = clamp(position.y, screen_limits.position.y, screen_limits.position.y + screen_limits.size.y)
