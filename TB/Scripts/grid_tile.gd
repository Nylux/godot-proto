extends RefCounted
class_name GridTile

## Data class used in grid_data singleton.
## Represents a single tile on the map.

var occupied : bool = false
var hit_array = []
var coords = Vector2()

func _init(tile_coords: Vector2):
	self.coords = tile_coords
