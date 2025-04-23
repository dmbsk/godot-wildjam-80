extends Node2D

class_name BuildingComponent

@export var build_block_scene: PackedScene;

@export var level: Level

@onready var build_cursor: Sprite2D = %BuildCursor

var levelTilemap: TileMapLayer

func _ready():
	position = Vector2.ZERO

func _input(event):
	var mouse_pos = get_global_mouse_position() + level.global_position + level.tilelayer.global_position
	var tile_pos = level.tilelayer.local_to_map(level.tilelayer.to_local(mouse_pos))
	var tilemapMousePos = level.tilelayer.map_to_local(tile_pos)
	build_cursor.position = tilemapMousePos
	
	var tile_data = level.tilelayer.get_cell_tile_data(level.tilelayer.local_to_map(level.tilelayer.to_local(get_global_mouse_position())))
	print(tile_data)
	if tile_data == null:
		build_cursor.modulate = Color(1, 1, 1, 1) # White for empty tiles
	else:
		build_cursor.modulate = Color(1, 0, 0, 1) # Red for occupied tiles
	
	if (event.is_action("build_place") and tile_data == null):
		place_build(tilemapMousePos)
		
func place_build(pos: Vector2):
	var new_block: Node2D = build_block_scene.instantiate()
	new_block.position = pos
	add_child(new_block)
