extends State
@onready var player: CharacterBody2D = $"../.."
@export var dash_speed: float = 1000.0
@export var dash_max_distance: float = 300.0
@export var dash_curve: Curve
@export var dash_cooldown: float = 1.0 
var dash_start_position := 0
var dash_direction := 0
var dash_timer := 0

func Enter():
	#Remember to add correct sprite
	print("Entering Dash State")
	
	dash_start_position = player.position.x 
	dash_direction = 1
	dash_timer = dash_cooldown
	




func Update(_delta):
	pass

func Physics_Update(_delta):
	pass
	
func Exit():
	pass
