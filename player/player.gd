extends Entity

var state = "default"
var keys = 0

func _physics_process(_delta):
	# Like switch statement in other languages
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
	
	# Sets the maximum keys value
	keys = min(keys, 9)

func state_default():
	controls_loops()
	movement_loop()
	spritedir_loop()
	damage_loop()
	
	# Run animation depending on whether you are walking or colliding with a wall
	if is_on_wall() and movedir != dir.stopped:
		if spritedir == "up" and test_move(transform, dir.up):
			anim_switch("push")
		if spritedir == "down" and test_move(transform, dir.down):
			anim_switch("push")
		if spritedir == "left" and test_move(transform, dir.left):
			anim_switch("push")
		if spritedir == "right" and test_move(transform, dir.right):
			anim_switch("push")	
	elif movedir != dir.stopped:
		anim_switch("walk")
	else:
		anim_switch("idle")
		
	# When key is pressed preload the sword scene
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))

# State of when player is using the sword
func state_swing():
	# Switch animation
	anim_switch("swordatk")
	movement_loop()
	damage_loop()
	# Stop player when using sword
	movedir = dir.stopped

# Function that performs the controls in a loop verifying which key was pressed
func controls_loops():
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	
	# When a key is pressed, the player moves in the x and y coordinates
	movedir.y = - int(UP) + int(DOWN)	
	movedir.x = -int(LEFT) + int(RIGHT)
	
