extends CharacterBody2D

@export var jump_interval: float = 0.33;
@export var jump_height: float = 200;
@export var speed: float = 10000;

@export var gravity: float = 600;

@onready var jump_timer: Timer = %JumpTimer
@onready var jump_progress: ProgressBar = %JumpProgress

var can_jump: bool = false

func _ready() -> void:
    jump_timer.start(jump_interval)
    jump_timer.timeout.connect(handle_jump_timeout)

    jump_progress.max_value = jump_interval

func start_stop_timer() -> void:
    if(is_on_floor()):
        jump_timer.paused = false
        return
    
    jump_timer.paused = true

func _physics_process(delta: float) -> void:
    start_stop_timer()
    velocity.y += delta * gravity;
    velocity.x = delta * speed;

    if(can_jump):
        jump(delta);
    
    jump_progress.value = jump_timer.time_left
    print(jump_progress.value)
    move_and_slide()

func handle_jump_timeout():
    can_jump = true

func jump(_delta: float):
    velocity.y = -jump_height;
    can_jump = false;
    
