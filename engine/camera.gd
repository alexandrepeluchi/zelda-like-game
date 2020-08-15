extends Camera2D

# Sets the screen size
const SCREEN_SIZE = Vector2(160, 124)
# The size in pixel of the HUD
const HUD_THICKNESS = 16
var grid_pos = Vector2(0, 0)

func _ready():
	$area.connect("body_entered", self, "body_entered")
	$area.connect("body_exited", self, "body_exited")
	$area.connect("area_exited", self, "area_exited")

func _process(_delta):
	# Camera only work if it's on the same level of the player scene
	# Subtracts 16 pixels for the HUD
	var pos = get_node("../player").global_position - Vector2(0, 16)
	# Find the grid positions to move the camera around the scene
	var x = floor(pos.x / 160) * 160
	var y = floor(pos.y / 128) * 128
	# Set the global position of the camera 
	global_position = Vector2(x, y)
	
func get_grid_pos(pos):
	# Subtracts the pixels y size of the HUD
	pos.y -= HUD_THICKNESS
	# Find the grid positions to move the camera around the scene
	var x = floor(pos.x / SCREEN_SIZE.x)
	var y = floor(pos.y / SCREEN_SIZE.y)
	# Return the global position of the camera 
	return Vector2(x, y)

# When an entity enters a certain part of the scene, it enables enemy actions
func body_entered(body):
	if body.get("TYPE") == "ENEMY":
		body.set_physics_process(true)

# When an entity enters a certain part of the scene, it disables enemy actions
func body_exited(body):
	if body.get("TYPE") == "ENEMY":
		body.set_physics_process(false)

func area_exited(area):
	# Using get because if an area doesn't have the disappears the game crash
	if area.get("disappears") == true:
		# Delete pickups when player exit the area
		area.queue_free()
