extends Camera3D

var intpos # Intended position of the camera. lerp() smoothing is applied on top of this for nice camera movement
const camera_dist = 2 # Distance between cam and player

func _ready() -> void:
	intpos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var player = $"/root/Scene/MainPlayer"
	var adjusted_player_position = player.position + Vector3(0, 2.0, 0) # Camera follows point above player's head
	var distance = intpos.distance_to(adjusted_player_position)
	intpos = intpos + ((adjusted_player_position - intpos).normalized() * (distance - camera_dist))
	# ^^^ Push/pull camera depending on distance
	
	# Apply intended position to position, then rotate the camera!
	position = intpos # lerp(position, intpos, 0.1) # <-- makes camera shaky, do not recommend for now
	look_at(player.position + Vector3(0, 1, 0))
