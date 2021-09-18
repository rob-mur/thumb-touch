extends Control

export var dead_zone = 30
export var double_tap_time = 0.2
var joystick_dir = Vector2()

signal tap
signal double_tap
signal swipe_up
signal swipe_down
signal swipe_left
signal swipe_right

var original_position = Vector2()
onready var double_tap_timer = $DoubleTapTimer
var gesture_fired = false

func _ready():
	double_tap_timer.wait_time = double_tap_time

func _gui_input(event):
	if not (event is InputEventScreenTouch or event is InputEventScreenDrag):
		return
	
	if event is InputEventScreenTouch and event.pressed:
		original_position = event.position
		
		if double_tap_timer.is_stopped():
			double_tap_timer.start()
		else:
			emit_signal("double_tap")
			double_tap_timer.stop()
		
		return
	
	if event is InputEventScreenTouch and not event.pressed:
		joystick_dir = Vector2()
		gesture_fired = false
		
	if event is InputEventScreenDrag:
		if event.position.distance_to(original_position) < dead_zone:
			joystick_dir = Vector2()
			return
		double_tap_timer.stop()		
		joystick_dir = (event.position - original_position).normalized()
		
		if not gesture_fired:
			gesture_fired = true
			var joystick_angle = joystick_dir.angle()
			if - PI / 4 < joystick_angle and joystick_angle <= PI / 4:
				emit_signal("swipe_right")
			elif PI / 4 < joystick_angle and joystick_angle <= 3 * PI / 4:
				emit_signal("swipe_down")
			elif -3 * PI / 4 < joystick_angle and joystick_angle <= -PI / 4:
				emit_signal("swipe_up")
			else:
				emit_signal("swipe_left")
		


func _on_DoubleTapTimer_timeout():
	emit_signal("tap")
