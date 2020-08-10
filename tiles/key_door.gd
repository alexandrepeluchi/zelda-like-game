extends StaticBody2D

func _ready():
	$area.connect("body_entered", self, "body_entered")
	
func body_entered(body):
	# Checks if the body name is player and if player has less than 9 keys
	if body.name == "player" && body.get("keys") > 0:
		body.keys -= 1
		.queue_free()
