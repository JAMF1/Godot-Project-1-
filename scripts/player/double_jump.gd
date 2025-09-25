extends State

@onready var player: CharacterBody2D = $"../.."

#Add push around ledges when jumping using raycasts?
func Enter():
	#Remember to add correct sprite
	player.velocity.y = player.double_jump_velocity
	player.used_double_jump = true
	print("Entering Double Jump State")


func Physics_Update(delta): 
	#Dash
	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transition.emit(self.name, "dash")
		
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
		
	var direction = Input.get_axis("move_left","move_right")
	player.velocity.x = direction * player.speed
	
	if player.velocity.y >= -50:
		Transition.emit(self.name,"falling")
