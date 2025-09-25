extends State
@onready var player: CharacterBody2D = $"../.."

func Enter():
	#Remember to add correct sprite
	print("Entering Walk State")
	
	player.speed = player.walking_speed
		
	player.used_double_jump = false

func Update(_delta):
	if Input.is_action_pressed("run"):
		Transition.emit(self.name, "run")

	if Input.is_action_pressed("jump") and player.is_on_floor():
		Transition.emit(self.name, "jump")

	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		Transition.emit(self.name, "Idle")

	if not player.is_on_floor():
		Transition.emit(self.name, "falling")

	#Dash
	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transition.emit(self.name, "dash")
	

func Physics_Update(_delta):
	var dir = Input.get_axis("move_left","move_right")
	
	if player.smooth_movement_enabled and dir != 0:
		player.velocity.x = move_toward(player.velocity.x, 
		dir * player.speed, 
		player.speed * player.acceleration)
		#player.dash_direction = dir
		
	else:
		player.velocity.x = dir * player.walking_speed 
		#player.dash_direction = dir
