extends Node

func lost() -> void:	
	get_tree().change_scene_to_file("res://scene/end_scene.tscn")
