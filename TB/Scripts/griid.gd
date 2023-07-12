#extends Reference

class_name Griid

var data : Array

var height : int
var width : int

#############################
func template_iteration():
#	for y in range(height):
#		for x in range(width):
#			data[x][y]
	pass
#############################

# setter and getter for basic griid data is much easier in the form of:
# someGriid.data[x][y] = someValue
# someVar = someGriid.data[x][y]

func _init(newWidth: int = 1, newHeight: int = 1, initVal = null):
	height = newHeight
	width = newWidth
	
	assert(width>0 and height>0)
	
	var col1 : Array = []
	
	for _y in range(height):
		col1.append_array([initVal])
	
	data = []
	for _x in range(width):
		data.append_array([col1.duplicate()])

func findFirstCoord(valueToFind, failedReturnValue=Vector2(-1,-1)):
	for x in range(width):
		for y in range(height):
			if data[x][y] == valueToFind:
				return(Vector2(x,y))
	return(failedReturnValue)

func getValuesAsString(cellBeginString = "", cellEndString = "") -> String:
	var output = ""
	for y in range(height):
		for x in range(width):
			output += cellBeginString
			output += str(data[x][y])
			output += cellEndString
		output+="\n"
	return(output)

func coordInRange(coord : Vector2) -> bool:
	if coord.x<0 or coord.y<0:
		return(false)
	if coord.x>=width:
		return(false)
	if coord.y>=height:
		return(false)
	return(true)

func getAt(coord : Vector2, failedReturn = null):
	if coordInRange(coord):
		return data[coord.x][coord.y]
	return failedReturn

func setAt(coord : Vector2, value):
	if coordInRange(coord):
		data[coord.x][coord.y] = value
