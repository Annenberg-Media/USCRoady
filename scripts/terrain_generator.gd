class_name TerrainGenerator
extends TileMapLayer

var width = 15;
var height = 23;
var score = 0;
var min_x = -8;
var min_y = -1;
var line_num = 23;
var last_block = 0;

const ROAD = 0;
const GRASS = 1;

func _ready() -> void:
	load_intial_terrain();

func load_intial_terrain():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for y in height:
		var tile_type = rng.randi_range(0, 100)
		if tile_type <= 40 || y < 3:
			tile_type = GRASS;
		else:
			tile_type = ROAD;
		if y == height - 1: 
			last_block = tile_type;
		if tile_type == ROAD:
			print("create spawner")
				# create spawner for enemies
		for x in width:
			set_cell(Vector2i(x+min_x,-y + min_y), 0, Vector2i(tile_type,0), 0)

func load_new_terrain(): 
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num_lines = rng.randi_range(1, 9) # 1 (5), 2(6,7), 3(8,9), 4, 
	# TODO fix rand weights
	if num_lines == 5: num_lines = 1;
	if num_lines == 6 || num_lines == 7: num_lines = 2;
	if num_lines == 8 || num_lines == 9: num_lines = 3;
	#just flipflops last block, or could do weighted instead
	if last_block == 1: last_block = 0;
	else: last_block = 1;
	for y in num_lines:
		if last_block == ROAD:
				print("create spawner")
				# create spawner for enemies
		for x in width:
			set_cell(Vector2i(x+min_x,-line_num-y-1), 0, Vector2i(last_block,0), 0)
	line_num += num_lines;
