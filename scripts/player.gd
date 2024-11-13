#extends CharacterBody2D
#
#const MOVE_SPEED = 64;
#const MIDDLE_SQUARE = 10;
#
#var can_move = false;
#
#var score = 0;
#var below = 0;
#
#func get_score():
	#return score;
#
#func _physics_process(_delta):
	#if can_move:
		#var cameraBottom = get_node("Camera2D").get_screen_center_position().y + 640;
#
		#if Input.is_action_just_pressed("ui_right"):
#
			#position.x += MOVE_SPEED;
#
		#elif Input.is_action_just_pressed("ui_left"):
#
			#position.x -= MOVE_SPEED;
#
		#elif Input.is_action_just_pressed("ui_up"):
#
			#position.y -= MOVE_SPEED;
			#if below == 0:
				#score += 1;
				#get_parent().get_node("HUD").update_score(score);
				#if get_parent().get_node("TerrainGenerator").line_num - (MIDDLE_SQUARE + 2) < score:
					#get_parent().get_node("TerrainGenerator").load_new_terrain();
			#else:
				#below -= 1;
#
		#elif Input.is_action_just_pressed("ui_down"):
			#position.y += MOVE_SPEED;
			#below += 1;
		#
#
		#if position.y > -64 + cameraBottom:
			#below -= 1;
			#position.y = -64 + cameraBottom;
		#
		#position.x = clamp(position.x, -320, 320);
#
#func stop_movement():
	#can_move = false;
	#
#func start_movement():
	#can_move = true;


# I left the top code just in case something went wrong
extends CharacterBody2D

const MOVE_SPEED = 64
const MIDDLE_SQUARE = 10
const SQUASH_AMOUNT = Vector2(1.3, 0.7) 
const STRETCH_AMOUNT = Vector2(0.7, 1.3) 
const ANIMATION_SPEED = 0.2
const NORMAL_SCALE = Vector2(1, 1)

var can_move = false
var score = 0
var below = 0

# Fake animation by making player go boing boing boing
# Can update player sprite as well
var is_animating = false

# Scoping here
@onready var sprite = $Sprite2D
@onready var move_sound = $MoveSound  # Sound stuff (movesound node is child of characterbody2d)

func get_score():
	return score

func _ready():
	sprite.scale = NORMAL_SCALE

func animate_squash():
	if is_animating:
		return
	
	is_animating = true
	
	# https://docs.godotengine.org/en/stable/classes/class_tween.html
	var tween = create_tween()
	tween.tween_property(sprite, "scale", SQUASH_AMOUNT, ANIMATION_SPEED * 0.5)
	tween.tween_property(sprite, "scale", NORMAL_SCALE, ANIMATION_SPEED * 0.5)
	tween.tween_callback(func(): is_animating = false)

func animate_stretch():
	if is_animating:
		return
	
	is_animating = true
	
	var tween = create_tween()
	tween.tween_property(sprite, "scale", STRETCH_AMOUNT, ANIMATION_SPEED * 0.5)
	tween.tween_property(sprite, "scale", NORMAL_SCALE, ANIMATION_SPEED * 0.5)
	tween.tween_callback(func(): is_animating = false)

# https://www.soundsnap.com/search/audio?query=boing&maxaudio=1%2C183
func play_move_sound():
	if move_sound and move_sound.stream:
		move_sound.play()

func _physics_process(_delta):
	if can_move:
		var cameraBottom = get_node("Camera2D").get_screen_center_position().y + 640
		var moved = false

		if Input.is_action_just_pressed("ui_right"):
			position.x += MOVE_SPEED
			animate_squash()
			moved = true

		elif Input.is_action_just_pressed("ui_left"):
			position.x -= MOVE_SPEED
			animate_squash()
			moved = true

		elif Input.is_action_just_pressed("ui_up"):
			position.y -= MOVE_SPEED
			animate_stretch()
			moved = true
			if below == 0:
				score += 1
				get_parent().get_node("HUD").update_score(score)
				if get_parent().get_node("TerrainGenerator").line_num - (MIDDLE_SQUARE + 2) < score:
					get_parent().get_node("TerrainGenerator").load_new_terrain()
			else:
				below -= 1

		elif Input.is_action_just_pressed("ui_down"):
			position.y += MOVE_SPEED
			animate_squash()
			moved = true
			below += 1

		if moved:
			play_move_sound()

		if position.y > -64 + cameraBottom:
			below -= 1
			position.y = -64 + cameraBottom

		position.x = clamp(position.x, -320, 320)

func stop_movement():
	can_move = false

func start_movement():
	can_move = true
