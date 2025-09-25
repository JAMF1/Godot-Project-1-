extends State
@onready var player: CharacterBody2D = $"../.."

#Add push around ledges when jumping using raycasts?
func Enter():
	#Remember to add correct sprite
	player.velocity.y = player.jump_velocity
	print("Entering Jump State")


func Physics_Update(delta):
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta

	if Input.is_action_just_pressed("jump") and not player.is_on_floor():
		Transition.emit(self.name, "double_jump")
	
	if Input.is_action_just_released("jump") and player.velocity.y < -50: 
		player.velocity.y = player.jump_velocity / 4
		
	var direction = Input.get_axis("move_left","move_right")
	player.velocity.x = direction * player.speed
	
	if player.velocity.y >= -50:
		Transition.emit(self.name,"falling")
