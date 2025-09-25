extends CharacterBody2D

@export var smooth_movement_enabled: bool = true 

#JUMPING VARIABLES
@export var jump_velocity: float = -800.0 
@export var gravity: float = 1500
@export var fall_gravity: float = 2500
#DOUBLE JUMP VARIABLES
@export var double_jump_velocity: float = -400.0 
var used_double_jump = false


@export var walking_speed: float = 600.0
@export var run_speed: float = 1000.0
var speed: float = 600.0 
var deacceleration: float = 0.1
var acceleration: float = 0.1 

func _physics_process(_delta: float) -> void:
	move_and_slide()
