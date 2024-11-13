#extends Sprite2D
#
#var has_rotated = false
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#var file = "res://assets/anim_data.json"
	#var json_string = FileAccess.get_file_as_string(file)
	#var data = JSON.parse_string(json_string);
	#var rng = RandomNumberGenerator.new();
	#rng.randomize();
	#var idx = rng.randi_range(0,5);
	#texture = load("res://assets/sprites/"+data[idx].filename);
	#hframes = int(data[idx].hframes);
	#render_sprites();
#
#func _process(_delta: float) -> void:
	#if get_parent().dir < 0 && !has_rotated:
		#for sprite in get_children():
			#sprite.rotation = PI;
			#has_rotated = true;
	#pass
#
#func render_sprites():
	#for i in range(0, hframes):
		#var next_sprite = Sprite2D.new();
		#next_sprite.texture = texture;
		#next_sprite.hframes = hframes;
		#next_sprite.frame = i;
		#next_sprite.position.y = -i;
		#add_child(next_sprite);



# I left the top stuff just in case
extends Sprite2D

var current_frame = 0
var facing_left = false
var animation_frames = 0

func _ready() -> void:
	var file = "res://assets/anim_data.json"
	var json_string = FileAccess.get_file_as_string(file)
	var data = JSON.parse_string(json_string)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var idx = rng.randi_range(0, 5)
	texture = load("res://assets/sprites/" + data[idx].filename)
	hframes = int(data[idx].hframes)
	animation_frames = hframes
	centered = true

func _process(_delta: float) -> void:
	# Parent node give directions
	var current_dir = get_parent().dir
	
	# Flips sprite based on direction
	if current_dir < 0 and not facing_left:
		flip_sprite(true)
	elif current_dir >= 0 and facing_left:
		flip_sprite(false)
	
	# Update frame
	update_visible_frame()

func update_visible_frame():
	# Update the frame
	frame = current_frame
	
	# Next frame
	current_frame = (current_frame + 1) % animation_frames

func flip_sprite(left: bool):
	facing_left = left
	flip_h = left
