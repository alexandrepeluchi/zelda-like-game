extends Node2D

var TYPE = null

# The damage the sword does
const DAMAGE = 1

# How many items the entity can create that could be active at once
var maxamount = 1

func _ready():
	# Type will be the same as the parent (in this case "PLAYER")
	TYPE = get_parent().TYPE
	# Connects with an animation signal
	$anim.connect("animation_finished", self, "destroy")
	# Play the animation based in the direction
	$anim.play(str("swing", get_parent().spritedir))
	
	# Changing the player's state to swing when using a sword
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"

# As soon as the animation has finished
func destroy(_animation):
	if get_parent().has_method("state_swing"):
		# Changing the player's state to default when sword animation is finished
		get_parent().state = "default"
	# Delete itself
	.queue_free()


