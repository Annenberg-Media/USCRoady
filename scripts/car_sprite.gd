extends Sprite2D

var has_rotated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = "res://assets/anim_data.json"
	var json_string = FileAccess.get_file_as_string(file)
	var data = JSON.parse_string(json_string);
	var rng = RandomNumberGenerator.new();
	rng.randomize();
	var idx = rng.randi_range(0,5);
	texture = load("res://assets/sprites/"+data[idx].filename);
	hframes = int(data[idx].hframes);
	render_sprites();

func _process(_delta: float) -> void:
	if get_parent().dir < 0 && !has_rotated:
		for sprite in get_children():
			sprite.rotation = PI;
			has_rotated = true;
	pass

func render_sprites():
	for i in range(0, hframes):
		var next_sprite = Sprite2D.new();
		next_sprite.texture = texture;
		next_sprite.hframes = hframes;
		next_sprite.frame = i;
		next_sprite.position.y = -i;
		add_child(next_sprite);
