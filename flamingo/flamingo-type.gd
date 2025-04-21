extends Node2D

class_name FlamingoType

enum TYPE {
	RED,
	BLUE,
	GREEN
}

var COLLISION_GROUP = {
	TYPE.RED: 9,
	TYPE.BLUE: 10, 
	TYPE.GREEN: 11
}

func getCollisionGroup(type: TYPE):
	return COLLISION_GROUP.get(type)

var TYPE_COLOR = {
	TYPE.RED: Color.RED,
	TYPE.BLUE: Color.BLUE,
	TYPE.GREEN: Color.GREEN
}
	
func getCollisionColor(type: TYPE) -> Color:
	return TYPE_COLOR.get(type)
