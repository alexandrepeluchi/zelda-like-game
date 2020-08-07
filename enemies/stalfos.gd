extends Entity

const DAMAGE = 1

var movetimer_length = 15
var movetimer = 0

func _ready():
	# Run the default animation
	$anim.play("default")
	
	# Randomizes the direction
	movedir = dir.rand()
	
func _physics_process(_delta):
	movement_loop()	
	damage_loop()
	
	# When the timer runs out it changes the direction randomly
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length
