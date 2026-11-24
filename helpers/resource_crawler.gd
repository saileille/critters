## Find and return custom resources in the project, wherever they may be.
class_name ResourceCrawler

## The root of the project directory.
static var entry_point: String = "res://"

## All filepaths of resource files, and their types - storing variable.
static var _resource_files: Dictionary[String, Array] = {}

## All filepaths of resource files, and their types - getter variable.
static var resource_files: Dictionary[String, Array]:
	get:
		if _resource_files.is_empty():
			_get_resource_files()
		return _resource_files


## Get the valid resource files. 
static func _get_resource_files() -> void:
	_resource_files = _get_resource_files_in_dir(entry_point)


## Get the valid resource files in a specific directory.
static func _get_resource_files_in_dir(dir: String) -> Dictionary[String, Array]:
	var files: Dictionary[String, Array] = {}
	for child: String in ResourceLoader.list_directory(dir):
		# Handle directories.
		if child.ends_with("/"):
			var dir_files: Dictionary[String, Array] = _get_resource_files_in_dir(dir + child)
			for type: String in dir_files:
				var filelist: Array = files.get_or_add(type, [])
				filelist.append_array(dir_files[type])

		# Handle files.
		else:
			var path: String = dir + child
			if _is_resource(path):
				var resource: Resource = ResourceLoader.load(path)
				var script: Script = resource.get_script()
				if script == null or script.get_global_name() == "":
					continue
				
				var filelist: Array = files.get_or_add(script.get_global_name(), [])
				filelist.append(path)

	return files


## Get all resources in the project that have the given [param type].
static func get_all(type: String) -> Array[Resource]:
	var resources: Array[Resource] = []
	if !resource_files.has(type):
		return resources

	var files: Array = resource_files[type]
	for file: String in files:
		resources.append(ResourceLoader.load(file))

	return resources


## Check if the file is a resource.
static func _is_resource(path: String) -> bool:
	return path.ends_with(".tres")
