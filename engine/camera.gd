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
	var player_grid_pos = get_grid_pos(get_node("../player").global_position)	
	# Sets the cameras global position to the players
	global_position = player_grid_pos * SCREEN_SIZE
	# Sets the camera grid position to the player grid position 
	grid_pos = player_grid_pos
	
func get_grid_pos(pos):
	# Subtracts the pixels y size of the HUD
	pos.y -= HUD_THICKNESS
	# Find the grid positions to move the camera around the scene
	var x = floor(pos.x / SCREEN_SIZE.x)
	var y = floor(pos.y / SCREEN_SIZE.y)
	# Return the global position of the camera 
	return Vector2(x, y)
	
# Check and return how many enemies are in the screen
func get_enemies():
	# Array that contains all the enemies of a screen
	var enemies = []
	# Loop to find all enemies of a screen
	for body in $area.get_overlapping_bodies():
		# If the body is an enemy and it's not inside the array
		if body.get("TYPE") == "ENEMY" && enemies.body == -1:
			# Added the enemy to the array
			enemies.append(body)
	# Return the total of enemies in the scree
	return enemies.size()

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
