extends TileMap

# Load block scene
var block = preload("res://tiles/block.tscn")

func _ready():
	# Make every block scene invible
	self.visible = false
	# Get the sprite id from the tilemap
	var block_tile = get_used_cells_by_id(0)
	# Loop that cycles through all enemy blocks added to the scene
	for tile in block_tile:
		# Create and add a instance to a variable
		var block_instance = block.instance()
		# Find the correct intance global position based on the cell size
		block_instance.global_position = map_to_world(tile) + cell_size / 2
		# Added the enemy block to the scene
		add_child(block_instance)
