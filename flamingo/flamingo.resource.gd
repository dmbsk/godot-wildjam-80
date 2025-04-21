extends Resource

class_name FlamingoResource

@export var type: GlobalFlamingoType.TYPE = GlobalFlamingoType.TYPE.RED

func set_collision(collision_object: CollisionObject2D):
	var coll: int = GlobalFlamingoType.COLLISION_GROUP.get(type)
	collision_object.set_collision_layer_value(coll, 1)
	collision_object.set_collision_mask_value(coll, 1)

func set_color(sprite: Sprite2D):
	sprite.modulate = GlobalFlamingoType.getCollisionColor(type)
	
