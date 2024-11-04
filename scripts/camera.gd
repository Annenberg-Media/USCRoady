extends Camera2D

var score = 0;
var MIDDLE = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MIDDLE = get_parent().MIDDLE_SQUARE;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var temp_score = get_parent().score;
	if temp_score > MIDDLE && temp_score != score:
		score = temp_score;
		limit_bottom = (score - MIDDLE) * -64;
