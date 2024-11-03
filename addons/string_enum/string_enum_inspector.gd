# ╔═════════════════════════════════════════════════════════════════════╗
# ║ This file is licensed under the Mozilla Public License Version 2.0. ║
# ╚═════════════════════════════════════════════════════════════════════╝

extends EditorInspectorPlugin


var StringEnumEditor := load("res://addons/string_enum/string_enum_editor.gd")
var StringEnumPlugin := load("res://addons/string_enum/string_enum_plugin.gd")

var currrent_object: Object
var dictionary_keys: Dictionary


func _can_handle(object: Object) -> bool:
	return true


## Check if the property is a string and has the correct suffix to be handled by the enum string addon.
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	## If we have a different object, then clear the dictionary_keys
	if currrent_object != object:
		currrent_object = object
		dictionary_keys = {}
	
	## Check if the property is correct
	if (
		type != TYPE_STRING
		or not hint_string.is_empty()
		or object.get_script() == null
		or not name.contains("_")
	):
		return false
	
	## Optimisation to get Enum keys only once for the same object
	if dictionary_keys.is_empty():
		var constant_map: Dictionary = object.get_script().get_script_constant_map()
		var value: Variant
		
		for item in constant_map:
			value = constant_map[item]
			
			if value is Dictionary:
				dictionary_keys[item] = value
	
	## Check if the last part of the string is a Enum
	var id_split := name.split("_", false)
	
	if id_split.size() < 2:
		return false
	
	var id := id_split[-1]
	
	if not id in dictionary_keys.keys():
		return false
	
	## Create the Editor
	var names := PackedStringArray(dictionary_keys[id].keys())
	
	## Create the label
	var label: String = name.trim_suffix("_%s" % id).capitalize()
	
	add_property_editor(name, StringEnumEditor.new(names), false, label)
		
	return true
