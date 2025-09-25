extends Node

@export var initial_state : State
var current_state : State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if states.get(state) != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	current_state = new_state

#---------------------
#Reset function in case of death for player
#-----------------------
func reset() -> void:
	print("Resetting state machine...")
	if current_state:
		print("Exiting current state: ", current_state.name)
		current_state.Exit()
		current_state = null

	if initial_state:
		print("Re-entering initial state: ", initial_state.name)
		current_state = initial_state
		current_state.Enter()
