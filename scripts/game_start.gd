extends CanvasLayer

const START_TIMER = 5;
var timer = 0;
var active = true;


func _ready() -> void:
	if Global.data.high_score != 0:
		hide();
		get_node("../Player").start_movement();
		active = false;


func _process(delta: float) -> void:
	if timer < START_TIMER:
		timer += delta;
	elif active:
		hide();
		get_node("../Player").start_movement();
		active = false;
