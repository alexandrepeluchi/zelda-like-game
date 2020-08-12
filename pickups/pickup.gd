class_name Pickup extends Area2D

# Tell the camera which variables we have to delete
export(bool) var disappears = false

func _ready():
	connect("body_entered", self, "body_entered")
	connect("area_entered", self, "area_entered")
	
func area_entered(area):
	var area_parent = area.get_parent()	
	if area_parent.name == "sword":
		body_entered(area_parent.get_parent())

func body_entered(_body):
	pass
