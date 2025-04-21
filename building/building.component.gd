extends Node2D

class_name BuildingComponent

@export var build_block_scene: PackedScene;

@onready var build_cursor: Sprite2D = %BuildCursor

func _ready():
	position = Vector2.ZERO 

func _input(event):
	build_cursor.position = get_global_mouse_position()
	
	if(event.is_action("build_place")):
		print("placing block")
		place_build(get_global_mouse_position())
		
func place_build(pos: Vector2):
	var new_block: Node2D = build_block_scene.instantiate()
	new_block.position = pos
	add_child(new_block)
	
	
