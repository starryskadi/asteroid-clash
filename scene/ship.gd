extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	pass # Replace with function body.

func _on_area_entered(area: Area2D) -> void:	
	if area.is_in_group('asteroid'):		
		Global.lost()
