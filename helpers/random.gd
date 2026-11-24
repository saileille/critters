class_name RandomExt


## Get a random [float] between 0.0 (inclusive) and 1.0 (exclusive).
static func rand_float() -> float:
	var value: float = 1.0
	while value == 1.0:
		value = randf()
	return value
