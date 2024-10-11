extends Area2D
@onready var sprite_2d: Sprite2D = %Sprite2D

var packed_scene = [
	preload("res://assets/asteroid.png"),
	preload("res://assets/asteroid_2.png")
]

var direction = Vector2(0, 0)
var max_speed := randf_range(50, 100)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = packed_scene.pick_random()
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:	
	if not area.is_in_group('asteroid'):
		queue_free()

func _process(delta: float) -> void:
	position += direction * max_speed * delta
