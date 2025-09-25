extends State
@onready var player: CharacterBody2D = $"../.."

#var is_invincible: bool = false
#var dash_speed: float = 1000.0
#var dash_max_distance: float = 300.0
#@export var dash_curve: Curve
#var dash_cooldown: float = 1.0
#var is_dashing: bool = false
#var dash_start_position := 0 
#var dash_direction := 0 
#var dash_timer := 0 


func Enter():
	print("Entering Dash State")
	if player.can_dash:
		player.is_invincible = true
		player.can_dash = false
		player.is_dashing = true
		player.dash_start_position = player.position.x 
		player.dash_timer = player.dash_cooldown 
	
	if Input.is_action_pressed("move_right"):
		player.dash_direction = 1
	elif Input.is_action_pressed("move_left"):
		player.dash_direction = -1
	else:
		player.dash_direction = sign(player.velocity.x) if player.velocity.x != 0 else 1


func Update(_delta):
	if not player.is_dashing: 
		if not player.is_on_floor():
			Transition.emit(self.name, "falling")
		if player.is_on_floor() and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
			Transition.emit(self.name, "walk")
		else:
			Transition.emit(self.name, "idle")

func Physics_Update(_delta):
	if player.is_dashing:
		var current_distance = abs(player.position.x - player.dash_start_position)
		if current_distance >= player.dash_max_distance or player.is_on_wall():
			player.is_dashing = false 
			player.velocity.x = 0

		else: 
			player.velocity.x = player.dash_direction * player.dash_speed * player.dash_curve.sample(current_distance / player.dash_max_distance)
			player.velocity.y = 0

func Exit():
	player.is_invincible = false
