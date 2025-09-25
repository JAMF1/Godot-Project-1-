extends CharacterBody2D

@export var smooth_movement_enabled: bool = true 
var deacceleration: float = 0.1
var acceleration: float = 0.1 

@export var walking_speed: float = 600.0
@export var run_speed: float = 1000.0
var speed: float = 600.0 


#JUMPING VARIABLES
@export var jump_velocity: float = -800.0 
@export var gravity: float = 1500
@export var fall_gravity: float = 2500
#DOUBLE JUMP VARIABLES
@export var double_jump_velocity: float = -500.0 
var used_double_jump = false

#DASH PARAMETERS / Dodge parameters
var is_invincible: bool = false
var can_dash: bool = false

@export var dash_curve: Curve
var dash_speed: float = 1000.0
var dash_max_distance: float = 300.0

var is_dashing: bool = false
var dash_start_position := 0 
var dash_direction := 0 

var dash_cooldown: float = 1.0
var dash_timer: float = 0.0 

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	#Dash Timer 
	if dash_timer > 0:
		dash_timer -= delta
	else:
		can_dash = true
	
