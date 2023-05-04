func on_button_pressed():
	# Check if the selected tower can be built on the clicked platform
	if clicked_platform.can_build and clicked_platform.buildable_tower == selected_tower:
		# Instantiate and place the tower on the clicked platform
		var tower = Tower.instance()
		tower.position = clicked_platform.position
		add_child(tower)
