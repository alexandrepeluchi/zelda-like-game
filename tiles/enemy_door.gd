extends StaticBody2D

# When the app is ready find the camera and player node
onready var camera = get_node("../camera")
onready var player = get_node("../player")

func _ready():
	# Open the doors when game starts
	$anim.play("open")
	
func _process(delta):
	if camera.grid_pos == camera.get_grid_pos(global_position):
		# If there is no enemy on the screen
		if camera.get_enemies() == 0:
			# Open the door
			if $anim.assigned_animation != "open":
				$anim.play("open")
			# If player enter the room
		elif !$area.get_overlapping_bodies().has(player):
			# Close the door
			if $anim.assigned_animation != "close":
				$anim.play("close")
	else:
		if $anim.assigned_animation != "open":
				$anim.play("open")
