extends Node

func lost() -> void:	
	get_tree().call_deferred('change_scene_to_file',"res://scene/end_scene.tscn")
