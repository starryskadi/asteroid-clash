extends Area2D

var direction := Vector2(0, 0)
var max_speed := 300
 
func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D):
	if area.is_in_group("asteroid"):
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var viewport_size := get_viewport_rect().size 
	
	position += direction * max_speed * delta
	
	# Performance Fix: Delete the bullet if go out of the screen
	if position.x < 0 or position.x > viewport_size.x or position.y < 0 or position.y > viewport_size.y:
		queue_free()
