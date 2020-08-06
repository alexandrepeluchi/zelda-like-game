extends Entity

const DAMAGE = 1

var movetimer_length = 15
var movetimer = 0

func _ready():
	$anim.play("default")
	movedir = dir.rand()
	
func _physics_process(_delta):
	movement_loop()	
	damage_loop()
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length
