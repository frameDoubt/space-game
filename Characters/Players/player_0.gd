extends RigidBody2D

var strafe_thrust = 320
var maneuvering_thrust = 200
var accelerate = Vector2(0, -250)
var brake = Vector2(0, 250)
var strafe_thrust_left = Vector2(-strafe_thrust, 0)
var strafe_thrust_right = Vector2(strafe_thrust, 0)
var forward_maneuver = Vector2(0, -maneuvering_thrust)
var back_maneuver = Vector2(0, maneuvering_thrust)
var torque = 1000

func _integrate_forces(state):
	var rotation_direction = 0
	if Input.is_action_pressed("accelerate"):
		state.apply_central_force(state.get_total_gravity() + accelerate.rotated(rotation))
	if Input.is_action_pressed("brake"):
		state.apply_central_force(state.get_total_gravity() + brake.rotated(rotation))
	else:
		state.apply_force(state.get_total_gravity() + Vector2())
	if Input.is_action_pressed("yaw_right"):
		rotation_direction += 1
	if Input.is_action_pressed("yaw_left"):
		rotation_direction -= 1
	if Input.is_action_just_pressed("strafe_left"):
		state.apply_central_impulse(state.get_total_gravity() + strafe_thrust_left.rotated(rotation))
	if Input.is_action_just_pressed("strafe_right"):
		state.apply_central_impulse(state.get_total_gravity() + strafe_thrust_right.rotated(rotation))
	if Input.is_action_just_pressed("forward"):
		state.apply_central_impulse(state.get_total_gravity() + forward_maneuver.rotated(rotation))
	if Input.is_action_just_pressed("back"):
		state.apply_central_impulse(state.get_total_gravity() + back_maneuver.rotated(rotation))
	state.apply_torque(rotation_direction * torque)
