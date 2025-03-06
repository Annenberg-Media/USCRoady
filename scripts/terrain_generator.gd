extends TileMapLayer

@export var spawner_scene: PackedScene

var width = 13;
var height = 23;
var score = 0;
var min_x = -7;
var min_y = -4;
var line_num = 3;
var last_block = 1;
const ROAD = 0;
const GRASS = 1;

func _ready() -> void:
	load_new_terrain();

func load_new_terrain():
	score = get_parent().get_node("Player").get_score();
	while line_num <  score + height:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var num_lines = rng.randi_range(1, 9) # 1 (5), 2(6,7), 3(8,9), 4, 
		if num_lines == 5: num_lines = 1;
		if num_lines == 6 || num_lines == 7: num_lines = 2;
		if num_lines == 8 || num_lines == 9: num_lines = 3;
		if last_block == 1: last_block = 0;
		else: last_block = 1;
		for y in num_lines:
			if last_block == ROAD:
					var r = rng.randi_range(0, 1);
					var right = false;
					if r == 1: right = true;
					var spawner = spawner_scene.instantiate();
					spawner.right = right;
					spawner.y_pos = (-line_num-y-0.5)*8;
					add_child(spawner);
			var rand_idxs = [0,1,2,3,4,5,6,7,8,9,10,11,12];
			rand_idxs.shuffle();
			var count = 0;
			for x in width:
				set_cell(Vector2i(x+min_x,-line_num-y-1), 0, Vector2i(rand_idxs[count],last_block), 0);
				count += 1;
		line_num += num_lines;
