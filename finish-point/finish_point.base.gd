extends Area2D

@export var exit_for: FlamingoResource

func _ready():
    area_exited.connect(handle_area_exit)
    area_entered.connect(handle_area_enter)

func handle_area_exit(area: Area2D):
    print("something exited", area)
    pass

func handle_area_enter(area: Area2D):
    print("something entered", area)
    pass