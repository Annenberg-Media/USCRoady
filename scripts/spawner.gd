
extends StaticBody2D

@export var car_scene: PackedScene

var spawn_timer = 0;
var spawn_inc = 0;
var y_pos = 0;
var x_pos = 0;
var right = false;
var speed = 0;

func _ready() -> void:
	position.y = y_pos;
	if(right): position.x = -320;
	else: position.x = 320;
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	speed = rng.randi_range(50, 150);
	spawn_inc = rng.randf_range(1.0,2.0);

func _process(delta: float) -> void:
	spawn_timer -= delta;
	if (get_node("../../Player/Camera2D").get_screen_center_position().y + 704)/4 < y_pos: queue_free();
	if spawn_timer <= 0:
		spawn_timer = spawn_inc;
		var car = car_scene.instantiate();
		car.right = right;
		car.speed = speed;
		car.y_pos = y_pos;
		add_child(car);
