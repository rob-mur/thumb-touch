extends Control

var dead_zone

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
var touch_id = -1

func _input(event):
	if event is InputEventScreenTouch:
		if not event.pressed and event.index == touch_id:
			joystick_dir = Vector2()
			gesture_fired = false	
			touch_id = -1
	
	if event is InputEventScreenDrag and event.index == touch_id:
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

func _gui_input(event):

	if event is InputEventScreenTouch and event.pressed:
		touch_id = event.index
		original_position = event.position
		
		if double_tap_timer.is_stopped():
			double_tap_timer.start()
		else:
			emit_signal("double_tap")
			double_tap_timer.stop()

		


func _on_DoubleTapTimer_timeout():
	emit_signal("tap")
