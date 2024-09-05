class_name Player
extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

@onready var pivot = $Pivot

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	var x_axis = Input.get_axis("move_left", "move_right")
	var z_axis = Input.get_axis("move_up", "move_down")
	
	direction.x = x_axis
	direction.z = z_axis
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		pivot.basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y -= (fall_acceleration * delta) 
	
	velocity = target_velocity
	move_and_slide()
