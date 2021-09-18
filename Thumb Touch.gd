extends Control

signal left_tap
signal left_double_tap
signal left_swipe_up
signal left_swipe_down
signal left_swipe_right
signal left_swipe_left
signal right_tap
signal right_double_tap
signal right_swipe_up
signal right_swipe_down
signal right_swipe_right
signal right_swipe_left


onready var left = $Left
onready var right = $Right

export var dead_zone = 30
export var double_tap_time = 0.2

func _ready():
	left.double_tap_timer.wait_time = double_tap_time
	right.double_tap_timer.wait_time = double_tap_time
	
	left.dead_zone = dead_zone
	right.dead_zone = dead_zone

var left_joystick setget , get_left_joystick
var right_joystick setget , get_right_joystick

func get_left_joystick():
	return left.joystick_dir
	
func get_right_joystick():
	return right.joystick_dir

func _on_Left_double_tap():
	emit_signal("left_double_tap")

func _on_Left_tap():
	emit_signal("left_tap")

func _on_Left_swipe_down():
	emit_signal("left_swipe_down")

func _on_Left_swipe_left():
	emit_signal("left_swipe_left")

func _on_Left_swipe_right():
	emit_signal("left_swipe_right")

func _on_Left_swipe_up():
	emit_signal("left_swipe_up")


func _on_Right_double_tap():
	emit_signal("right_double_tap")

func _on_Right_swipe_down():
	emit_signal("right_swipe_down")

func _on_Right_swipe_left():
	emit_signal("right_swipe_left")

func _on_Right_swipe_right():
	emit_signal("right_swipe_right")

func _on_Right_swipe_up():
	emit_signal("right_swipe_up")

func _on_Right_tap():
	emit_signal("right_tap")
