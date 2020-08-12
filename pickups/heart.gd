extends Pickup

func body_entered(body):
	# Colliding with the player increases health and delete item
	if body.name == "player":
		body.health += 1
		.queue_free()
