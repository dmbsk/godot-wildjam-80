extends Resource

class_name FlamingoResource

@export var flamingoType: FlamingoType.Type = FlamingoType.Type.RED

func set_collisions(collision_object: CollisionObject2D):
    collision_object.collision_layer = FlamingoType.CollisionLayer[FlamingoType.Type.keys()[flamingoType]]
    pass