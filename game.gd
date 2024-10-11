extends Node2D

@onready var ship: Area2D = %Ship
@onready var bullet_packed: PackedScene = preload("res://scene/bullet.tscn")
@onready var direction: Vector2 = ship.position.normalized()
@onready var asteroid_packed: PackedScene = preload("res://scene/asteroid.tscn")
@onready var timer: Timer = %Timer
@onready var total_time: Timer = %TotalTime
var current_game_time := 1
var asteroid_time_interval := randf_range(0.5, 1)

var asteroid_offscreen_position := 20
var is_asteroid_x_turn := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = asteroid_time_interval
	timer.timeout.connect(_on_timer_timeout)
	
	total_time.timeout.connect(_on_total_time_timeout)

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event is InputEventMouseMotion:			
			var target_position = event.position - ship.position
			direction = target_position.normalized()
			ship.rotation = direction.angle()			
			
	if event.is_action_pressed("shoot"):
			var bullet = bullet_packed.instantiate()		
			bullet.position = ship.position		
			bullet.direction = direction
			add_child(bullet)	

func _on_timer_timeout() -> void:
	var asteroid = asteroid_packed.instantiate()
	var viewport_size := get_viewport_rect().size 
	var position_x = [{ "length": -asteroid_offscreen_position, "direction": 1 }, { "length": viewport_size.x + asteroid_offscreen_position, "direction": -1 }].pick_random()
	var position_y = [{ "length": -asteroid_offscreen_position, "direction": 1 }, { "length": viewport_size.y + asteroid_offscreen_position, "direction": -1 }].pick_random()
	
	if is_asteroid_x_turn:
		position_y.length = randf_range(0, viewport_size.y)
		is_asteroid_x_turn = false
	else: 
		position_x.length = randf_range(0, viewport_size.x)
		is_asteroid_x_turn = true
	
	asteroid.position = Vector2(position_x.length, position_y.length)
	asteroid.direction = Vector2(position_x.direction, position_y.direction)
	
	asteroid.scale = Vector2(1 , 1) * randf_range(1, 3)
	asteroid.rotation = randf_range(0, 2 * PI)
	
	add_child(asteroid)
		  
	timer.wait_time = asteroid_time_interval
	timer.start()

func _on_total_time_timeout() -> void:
	asteroid_time_interval = randf_range(3.0 / current_game_time, 5.0 / current_game_time)
	current_game_time += 1
