extends Control
@onready var button: Button = %Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_on_pressed_button)
	
func _on_pressed_button() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
