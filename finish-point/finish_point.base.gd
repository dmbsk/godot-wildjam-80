extends Area2D

@export var exit_for: FlamingoResource

@export var seconds_in_exit: float = 3;

@onready var timer = %Timer
@onready var sprite = %Sprite

var flamingo: FlamingoCharacter

func _ready():
	exit_for.set_collision(self)
	exit_for.set_color(sprite)
	body_entered.connect(handle_body_enter)
	body_exited.connect(handle_body_exit)

	timer.autostart = false
	timer.timeout.connect(handle_timeout)

func handle_body_exit(body: Node2D):
	if (body is FlamingoCharacter):
		timer.stop();
		body.exited_finish_zone.emit()
		var flamingo = null;

func handle_body_enter(body: Node2D):
	if (body is FlamingoCharacter):
		timer.start(seconds_in_exit);
		body.entered_finish_zone.emit()
		flamingo = body;
		
func handle_timeout():
	if (flamingo):
		flamingo.stayed_in_finish_zone.emit()
