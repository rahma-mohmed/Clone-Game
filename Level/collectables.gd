extends Node2D

var gem = preload("res://gem/gam.tscn")

func _on_timer_timeout():
	var gemtemp = gem.instantiate()
	var rand = RandomNumberGenerator.new()
	var randx = rand.randi_range(96,2300)
	gemtemp.position = Vector2(randx , 416)
	get_node("Node2D").add_child(gemtemp)
	
