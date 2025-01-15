extends CharacterBody3D

var model_radians = 0.0
var SPEED = 4.0
const JUMP_VELOCITY = 2
var model_init_y_rotation = 0

func _ready() -> void:
	var model = $"./PlayerModel"
	model_init_y_rotation = (model.rotation.y)
	print(model_init_y_rotation)
	$"./PlayerModel/AnimationPlayer".play(" world_walk")

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("3d_run"):
		SPEED = 25
	else:
		SPEED = 4.0
	
	var camera = $"/root/Scene/Camera"
	var model = $"./PlayerModel"
	
	rotation.y = camera.rotation.y
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("3d_lt", "3d_rt", "3d_ft", "3d_bk")
	

	if(input_dir.length() > 0.1):
		model_radians = acos(Vector3(input_dir.x, 0, input_dir.y).dot(Vector3.RIGHT))
		if(input_dir.y > 0): model_radians = model_radians * -1
	print(model_radians - 1.5707963267949)
	model.rotation.y = lerp(model.rotation.y - 1.5707963267949, model_radians - 1.5707963267949, 0.1) + 1.5707963267949 + model_init_y_rotation
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
