extends RigidBody

var curPos: Vector3 = Vector3()
var endPos: Vector3 = Vector3()
var dir_angle: float = 0

# Will try out later
var dead = false

func _ready():
	set_physics_process(true)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		dir_angle = 90
		endPos = curPos + Vector3(-1, 0, 0)
	elif Input.is_action_pressed("ui_right"):
		dir_angle = -90
		endPos = curPos + Vector3(1, 0, 0)
	elif Input.is_action_pressed("ui_up"):
		dir_angle = 0
		endPos = curPos + Vector3(0, 0, -1)
	elif Input.is_action_pressed("ui_down"):
		dir_angle = 180
		endPos = curPos + Vector3(0, 0, 1)

	# Move towards end pos
	curPos = curPos.linear_interpolate(endPos, delta * 20)
	var transition = (curPos / 0.05).round() * 0.05
	set_translation(transition)

	# Rotate player to face direction of movement
	rotation_degrees.y = dir_angle
