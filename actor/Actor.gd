extends KinematicBody2D

class_name Actor 

signal health_changed()


var GRAVITY: float = 500.0
const UP = Vector2(0, -1)
var velocity: Vector2 = Vector2.ZERO
var is_facing_right: bool = true
var is_attacking: bool = false
var speed: float
var attack: int
var health: int


onready var sprite: Sprite = $Sprite

func _physics_process(delta: float) -> void:
	if velocity.y > GRAVITY:
		velocity.y = GRAVITY
		
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	

func take_damage_old(amount: int):
	self.health -= amount
	emit_signal("health_changed")

func flip_sprite() -> void:
	self.scale.x *= -1 


func handle_facing_direction(x_input: int):
	if x_input == 1:
		if not is_facing_right:
			flip_sprite()
			is_facing_right = true
	elif x_input == -1:
		if is_facing_right:
			flip_sprite()
			is_facing_right = false
			
func handle_facing_direction_new(x_input: int):
	if x_input > 0:
		if not is_facing_right:
			flip_sprite()
			is_facing_right = true
	elif x_input < 0:
		if is_facing_right:
			flip_sprite()
			is_facing_right = false

