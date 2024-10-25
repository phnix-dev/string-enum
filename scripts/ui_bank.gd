# ╔═════════════════════════════════════════════════════════════════════╗
# ║ This file is licensed under the Mozilla Public License Version 2.0. ║
# ╚═════════════════════════════════════════════════════════════════════╝

# class_name UiBank
extends Node
## Stores every scene for easy retrieval at runtime.
##
## This class is used to store every scene path for easy retrieval at runtime, it is most useful when paired with the [code]string_enum[/code] addon to easily export the names of the scenes in [code]@export[/code] and load them afterwards.
## [br]
## You can use the [code]Create Enum From Folder[/code] tool to automatically create an enum based on the scenes in a folder.
## [br]
## This class should be used as an [code]Autoload[/code].



# the values are a example, they will be replaced at _ready
var _scenes: Dictionary = {
	"node_a": "res://node_a.tscn",
	"node_b": "res://node_b.tscn",
	"node_c": "res://node_c.tscn",
}


func _ready() -> void:
	_scenes = {}
	var scene_paths := _get_all_scenes("res://")
	
	for path in scene_paths:
		var scene_name := path.get_file().get_slice(".", 0)
		
		_scenes[scene_name] = path


## [param scene_name:] The filename of the scene to load without the extension [br]
## [param return:] A PackedScene or null if not found
func get_scene(scene_name: String) -> PackedScene:
	var path: String = _scenes.get(scene_name)
	
	if not path:
		return null
		
	return load(path)


func _get_all_scenes(path: String) -> Array[String]:
	var array: Array[String] = []
	var current_path: String
	
	var dir = DirAccess.open(path)
		
	if dir:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		
		while file_name != "":
			current_path = path.path_join(file_name)
			
			if dir.current_is_dir() and file_name != "addons":
				var subfolder_array = _get_all_scenes(current_path)
				
				array.append_array(subfolder_array)
				
			elif file_name.get_extension() == "tscn":
				array.append(current_path)
				
			file_name = dir.get_next()
	else:
		printerr("An error occurred when trying to access the path.")
		
		return []
	
	return array
