extends CanvasLayer


@onready var player_a = $"../Player_A"

@onready var turn_machine = %turn_machine

@onready var energy = $deck/energy
@onready var next_turn = $signboard/next_turn
@onready var timer = $signboard/timer
@onready var h_box_container = $deck/HBoxContainer


func _process(delta):
	energy.text = str(player_a.energy)
	
	match turn_machine.current_stage:
		0: timer.text = tr("PRE_INIT")
		1: timer.text = tr("INIT_STORVE")
		3: timer.text = tr("END")
	
	if turn_machine.current_stage == 2:
		timer.text = tr("OPP_TURN") if turn_machine.current_player else tr("YOU_TURN")
		timer.text +=  str(int(turn_machine.time_left))


func _turn_machine_main_turn(player):
	next_turn.disabled = player != TurnMachine.Players.A
	
	if player == PlayerController.Players.A:
		h_box_container.get_children().map(func(c): c.can_drop = true)



func _turn_machine_end_turn(player):
	next_turn.disabled = true
	
	h_box_container.get_children().map(func(c): c.can_drop = false)


func _next_turn_pressed():
	turn_machine.next_phase()
