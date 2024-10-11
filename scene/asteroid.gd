extends Area2D
@onready var sprite_2d: Sprite2D = %Sprite2D

var packed_scene = [
	preload("res://assets/asteroid.png"),
	preload("res://assets/asteroid_2.png")
]

var direction = Vector2(0, 0)
var max_speed := randf_range(50, 100)
var safe_spawn_added_size := 40 

var aestroid_types = {
	"big": {		
		"to": "medium",
		"to_count": 2,
		"scale": 3
	},
	"medium": {		
		"to": "small",
		"to_count": 2,
		"scale": 2
	},
	"small": {		
		"to": "none",
		"to_count": 1,
		"scale": 1
	}
}

var current_aestroid_type = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = packed_scene.pick_random()
	area_entered.connect(_on_area_entered)
	
	if !current_aestroid_type:
		current_aestroid_type = aestroid_types.keys().pick_random()	
	
	scale = Vector2(1 , 1) * aestroid_types[current_aestroid_type]["scale"]

func _on_area_entered(area: Area2D) -> void:	
	if not area.is_in_group('asteroid'):
		if current_aestroid_type == "small":
			queue_free()
			return
	
		for i in range(0, aestroid_types[current_aestroid_type].to_count):
			var parent = get_parent() 
		
			var new_aestroid = self.duplicate()
			new_aestroid.direction = Vector2(1, 1)  * randf_range(-1, 1)
			
			new_aestroid.current_aestroid_type = aestroid_types[current_aestroid_type].to
			
			parent.call_deferred('add_child', new_aestroid)
			call_deferred('queue_free')	

func _process(delta: float) -> void:
	position += direction * max_speed * delta
	var viewport_size := get_viewport_rect().size 

	# Performance Fix: Delete the bullet if go out of the screen
	if position.x < 0 or position.x > viewport_size.x + safe_spawn_added_size or position.y < 0 or position.y > viewport_size.y + safe_spawn_added_size:
		queue_free()
