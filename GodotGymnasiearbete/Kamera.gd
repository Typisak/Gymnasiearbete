extends Camera2D

const LOOK_AHEAD_FACTOR = 0.03
const SHIFT_TRANSITION = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_OUT
const SHIFT_DURATION = 1.0

onready var previous_position = get_camera_position()
onready var tween = $Tween

var facing = 0

func _check_facing():
	var new_facing = sign(get_camera_position().x - previous_position.x)
	if new_facing != 0 && facing != new_facing:
		facing = new_facing
		var target_offset = get_viewport_rect().size.x * facing * LOOK_AHEAD_FACTOR
		
		tween.interpolate_property(self, "position:x", position.x, target_offset, SHIFT_DURATION, SHIFT_TRANSITION, SHIFT_EASE)
		tween.start()


func _process(_delta):
	_check_facing()
	previous_position = get_camera_position()

func _on_Player_grounded_update(grounded):
	drag_margin_v_enabled = !grounded
