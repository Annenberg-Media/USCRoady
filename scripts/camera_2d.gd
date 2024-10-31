extends Camera2D

var score = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_parent().score > get_parent().MIDDLE_SQUARE && get_parent().score != score:
		score = get_parent().score;
		limit_bottom = (score - get_parent().MIDDLE_SQUARE) * -64;
