extends Area2D

const MAX_X = 500;
const MIN_Y = 100;
var speed = 0;
var right;
var dir = 0;
var y_pos = 0;
var x_pos = 0;


func _ready() -> void:
	position.y = y_pos;
	if(right): dir = 1; position.x = 200;
	else: dir = -1; position.x = -200;

func _process(delta: float) -> void:
	position.x += dir * speed * delta;
	if abs(position.x) > MAX_X : queue_free();


func _on_car_body_entered(_body: Node2D) -> void:
	get_node("../../../Player").stop_movement();
	var score = get_node("../../../Player").score;
	if Global.data.high_score < score: 
		Global.data.high_score = score;
	get_node("../../../GameOver").set_text(score, Global.data.high_score);
	get_node("../../../GameOver").show();
