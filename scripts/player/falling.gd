extends State
@onready var player: CharacterBody2D = $"../.."

@export var coyote_time: float = 0.1 
var coyote_time_clock: float = 0 

@export var jump_buffer_time: float = 0.1
var jump_buffer_clock: float = 0

func Enter():
	#Remember to add correct sprite
	print("Entering Fall State")
	jump_buffer_clock = 0 
	coyote_time_clock = coyote_time

func input(_event: InputEvent) -> void: 
	if Input.is_action_just_pressed("jump"):
		jump_buffer_clock = jump_buffer_time
	return 

func Update(_delta):
	#jump buffer
	if player.is_on_floor() and jump_buffer_clock > 0: 
		Transition.emit(self.name, "jump")
	#Coyote time?
	elif coyote_time_clock > 0 and jump_buffer_clock > 0: 
		Transition.emit(self.name, "jump")
		
	elif not player.is_on_floor() and not player.used_double_jump and Input.is_action_just_pressed("jump"):
		Transition.emit(self.name, "double_jump") 
		
	elif player.is_on_floor(): 
		Transition.emit(self.name, "idle")

	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transition.emit(self.name, "dash")

func Physics_Update(delta): 
	jump_buffer_clock = max(jump_buffer_clock - delta, 0)
	coyote_time_clock = max(coyote_time_clock - delta, 0)
	
	player.velocity.y += player.fall_gravity * delta 
	var direction = Input.get_axis("move_left","move_right")
	player.velocity.x = direction * player.speed
