class_name Entity extends KinematicBody2D

export(String) var TYPE = "ENEMY" 
export(int) var SPEED = 0
export(int) var MAXHEALTH = 0
# Health set
export(int) var health = MAXHEALTH

# Where the player/enemy will move in 8 directions
var movedir = dir.stopped

# Works the same as movedir but only will be used when entity knockback
var knockdir = dir.stopped

# The direction player is facing when game starts
var spritedir = "down"

# Variable to calculate knockback and make the entity unable to take damage
var hitstun = 0

# Texture sprites variables
var texture_default = null
var texture_hurt = null

func _ready():
	# Prevents any action by the enemy if the camera is not in the same grid
	if TYPE == "ENEMY":
		# Make enemy collide with the second layer from camera StaticBody2D
		set_collision_mask_bit(1, 1)
		set_physics_process(false)
	# Load default sprite
	texture_default = $Sprite.texture
	# Load hurt sprite
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))

# Loop function to move the player/enemy
func movement_loop():
	var motion
	# Check if entity is knockback
	if hitstun == 0:
		# Take the direction that player/enemy is going to move and multiply by speed
		# Move entity with default SPEED
		motion = movedir.normalized() * SPEED
	else:
		# Entity is knockback
		motion = knockdir.normalized() * 125
		
	# Considers all collisions as a wall
	move_and_slide(motion, dir.stopped)
	
# Loop that check sprite direction
func spritedir_loop():
	# Like switch statement in others languages
	match movedir:
		dir.up:
			spritedir = "up"
		dir.down:
			spritedir = "down"
		dir.left:
			spritedir = "left"
		dir.right:
			spritedir = "right"

# Function that switches the animations
func anim_switch(animation):
	# Concatenates the direction with the animation name to run the correct animation			
	var newAnim = str(animation, spritedir)
	# If animation is different from the current one
	if $anim.current_animation != newAnim:
		# Play new animation
		$anim.play(newAnim)		
		
# Function that calculates if entity suffers damage
func damage_loop():
	health = min(MAXHEALTH, health)
	# If entity is knockback change sprites
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		
		# If enemy health is gone
		if TYPE == "ENEMY" && health <= 0:
			var drop = randi() % 3
			# If drop equals 0 enemy drop a heart when killed (25% drop rate)
			if drop == 0:
				# Load heart pickup scene
				instance_scene(preload("res://pickups/heart.tscn"))
			# Load death animation scene
			instance_scene(preload("res://enemies/enemy_death.tscn"))
			# Delete itself
			.queue_free()
			
	# Returns a list of all Areas2D that are colliding with hitbox
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()		
		# If hitstun equal to 0 and body received damage from an entity of a different Type
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:			
			# Decreases health
			health -= body.get("DAMAGE")	
			# Makes the entity receive hitstun
			hitstun = 10	
			# And causes knockback depending on the X and Y coordinates
			knockdir = global_transform.origin - body.global_transform.origin 
	
# Function that makes an entity use an item
func use_item(item):
	# Pass the instance of an item
	var newitem = item.instance()
	# Added the item to a group based on the item and entity ID's number
	newitem.add_to_group(str(newitem.get_name(), self))
	# Create instance
	add_child(newitem)
	# Check how many items exists
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		# Delete itself
		newitem.queue_free()
		
func instance_scene(scene):
	# Added intance to run the scene
	var new_scene = scene.instance()
	# Added to new_scene the last enemy position based in X and Y coordinates
	new_scene.global_position = global_position
	# Run the scene
	get_parent().add_child(new_scene)
