extends entity

var state = "default"

func _physics_process(_delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()

func state_default():
	controls_loops()
	movement_loop()
	spritedir_loop()
	damage_loop()
	
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
		
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))
		
func state_swing():
	SPEED = 0
	anim_switch("swordatk")
	damage_loop()

func controls_loops():
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	
	movedir.y = - int(UP) + int(DOWN)	
	movedir.x = -int(LEFT) + int(RIGHT)
	
