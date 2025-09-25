extends State
@onready var player: CharacterBody2D = $"../.."

func Enter():
	#Remember to add correct sprite
	print("Entering Sprint State")
	player.speed = player.run_speed
	player.used_double_jump = false

func Update(_delta):
	if Input.is_action_pressed("jump") and player.is_on_floor():
		Transition.emit(self.name, "jump")
		
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and not Input.is_action_pressed("run"):
		Transition.emit(self.name, "walk")
		
	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		Transition.emit(self.name, "idle")

	if not player.is_on_floor():
		Transition.emit(self.name, "falling")

func Physics_Update(_delta):
	var dir = Input.get_axis("move_left","move_right")

	if player.smooth_movement_enabled and dir != 0:
		player.velocity.x = move_toward(player.velocity.x, 
		dir * player.speed, 
		player.speed * player.acceleration)
		
	else:
		player.velocity.x = dir * player.run_speed 
