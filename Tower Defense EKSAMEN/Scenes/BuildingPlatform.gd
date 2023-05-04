extends Area2D

# The tower that can be built on this platform
export(String) var buildable_tower = "tower"

# The color of the platform when a tower can be built on it
export(Color) var buildable_color = Color(0, 1, 0)

# The color of the platform when a tower cannot be built on it
export(Color) var non_buildable_color = Color(1, 0, 0)

# Whether a tower can be built on this platform
var can_build = true

func _on_BuildingPlatform_body_entered(body):
	# Check if the body is a tower that can be built on this platform
	if body.name == buildable_tower:
		# Set the color of the platform to the buildable color
		$Sprite.modulate = buildable_color
	else:
		# Set the color of the platform to the non-buildable color
		$Sprite.modulate = non_buildable_color
		can_build = false

func _on_BuildingPlatform_body_exited(body):
	# Reset the color of the platform to the default color
	$Sprite.modulate = Color(1, 1, 1)
	can_build = true
