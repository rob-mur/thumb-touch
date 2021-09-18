# Thumb Touch

This is a basic library for handling touch input for a landscape "two thumb" use case. Each side of the screen will handle input for the respective thumb which comes in the form of both an invisible joystick direction and various signals for taps and gestures. 

## Usage
The library provides a control node "Thumb Touch" which should be position using the "Full Rect" layout. The following outputs are then provided (note that each one comes with a left_ and right_ version):

 - **joystick:** a normalized Vector2 of the current direction if the thumb is acting as a joystick i.e.being held on the screen, with the original touch location being the center of the joystick
 - **Signals:** tap, double_tap, swipe_up, swipe_down, swipe_left, swipe_right

Note that the first movement when using a joystick will also result in a gesture being fired e.g. moving to the right will both update the joystick vector and fire swipe_right. Just listen to the one you want in you game!

## Configuration
There are two simple export options which can be used to tune the library:

 - **dead_zone:** this is the radius for which the library will consider a thumb to be stationary, which is used to tell the difference between taps and swipes, as well as "0" on the joystick. The default value was chosen for a Samsung M31, you may wish to increase/decrease this value depending on the phone resolution + size being targeted
 - **double_tap_time:** this is the amount of time that passes after a single tap before the library assumes just a single tap was intended. Alternatively this can be viewed as the maximum time that can be taken to perform a double tap and have it register as such instead of two single taps. Increase or decrease to your liking!

