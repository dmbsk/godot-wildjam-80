extends CharacterBody2D

class_name FlamingoCharacter

@export var flamingo_resource: FlamingoResource

@export var jump_interval: float = 0.33;

@export var jump_height: float = 200;
@export var speed: float = 10000;

@export var gravity: float = 600;

@export var direction: int = 1
@export var direction_time_change: float = 2
var last_direction: int = 0;

@onready var jump_timer: Timer = %JumpTimer
@onready var jump_progress: ProgressBar = %JumpProgress
@onready var sprite: AnimatedSprite2D = %Sprite
@onready var forward_raycast: RayCast2D = %ForwardRaycast
@onready var forward_raycast_timer: Timer = %RaycastTimer

var can_jump: bool = false
var is_in_exit: bool = false

signal entered_finish_zone
signal exited_finish_zone
signal stayed_in_finish_zone

func _ready() -> void:
	flamingo_resource.set_collision(self)
	flamingo_resource.set_color(sprite)
	jump_timer.start(jump_interval)
	jump_timer.timeout.connect(handle_jump_timeout)

	forward_raycast_timer.one_shot = true
	forward_raycast_timer.autostart = false
	forward_raycast_timer.timeout.connect(handle_direction_timer)
	
	entered_finish_zone.connect(handle_enter_finish_zone)
	exited_finish_zone.connect(handle_exit_finish_zone)
	stayed_in_finish_zone.connect(handle_stayed_in_finish_zone)

	jump_progress.max_value = jump_interval

func _physics_process(delta: float) -> void:
	start_stop_timer()
	velocity.y += delta * gravity;
	velocity.x = delta * speed * direction;

	sprite.play("run")

	if (can_jump):
		jump(delta);

	if (!is_on_floor()):
		sprite.play("jump")

	if (is_on_floor() && forward_raycast.get_collider() && forward_raycast_timer.is_stopped()):
			forward_raycast_timer.start(direction_time_change)

	if (!forward_raycast.get_collider()):
		forward_raycast_timer.stop()
			
	if (is_in_exit && is_on_floor()):
		velocity.x = 0
		sprite.play('in_exit')

	
	jump_progress.value = jump_timer.time_left
	move_and_slide()

func start_stop_timer() -> void:
	if (is_in_exit):
		jump_timer.paused = true
		return
	
	if (is_on_floor()):
		jump_timer.paused = false
		return
	
	jump_timer.paused = true

func handle_jump_timeout():
	can_jump = true

func jump(_delta: float):
	velocity.y = - jump_height;
	can_jump = false;

func handle_enter_finish_zone():
	is_in_exit = true
	
func handle_exit_finish_zone():
	is_in_exit = false
	
func handle_stayed_in_finish_zone():
	queue_free()

func handle_direction_timer():
	direction *= -1
	sprite.flip_h = !sprite.flip_h
	forward_raycast.rotation_degrees += 180
