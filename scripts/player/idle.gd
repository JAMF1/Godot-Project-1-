extends State
@onready var player: CharacterBody2D = $"../.."

func Enter():
	#Remember to add correct sprite
	player.used_double_jump = false
	print("Entering Idle State")

func Update(_delta):
	#Walk
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		Transition.emit(self.name, "walk")
	
	#Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transition.emit(self.name, "jump")
	
	#Falling
	if not player.is_on_floor():
		Transition.emit(self.name, "falling")
	#Dash
	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transition.emit(self.name, "dash")


func Physics_Update(_delta):
	if player.smooth_movement_enabled:
		player.velocity.x = move_toward(player.velocity.x,
		0, 
		player.walking_speed * player.deacceleration)
