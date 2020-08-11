extends CanvasLayer

# Player path in the player var
onready var player = get_node("../player")

# How many heart are in one row before start to drawn to the next row
const HEART_ROW_SIZE = 8
# How far apart one heart will be placed fater the last one
const HEART_OFFSET = 8

func _ready():
	# Creates a sprite for each heart that the player can have
	for i in player.MAXHEALTH:
		var new_heart = Sprite.new()
		new_heart.texture = $hearts.texture
		new_heart.hframes = $hearts.hframes
		$hearts.add_child(new_heart)

func _process(_delta):
	for heart in $hearts.get_children():
		# Tell us which place the heart in this iteration
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		
		# Finds the current sprite that correspond to the player health
		var last_heart = floor(player.health)
		# If index greater than last heart the heart will be empty (frame 0)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			# player.health (5.5) - last_heart (5) = 0.5 * 4 = 2 (frame 2 equal half heart)
			heart.frame = (player.health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4	
	$keys.frame = player.keys
