extends Node

# Directions Singleton
const stopped = Vector2(0,0)
const up = Vector2(0,-1)
const down = Vector2(0,1)
const left = Vector2(-1,0)
const right= Vector2(1,0)

# Function to make the enemy move random
func rand():
	# Like switch statements in other languages
	match (randi() % 4 + 1):
		1: 
			return up
		2: 
			return down
		3:
			return left
		4:
			return right
	
