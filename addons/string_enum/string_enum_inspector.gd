extends EditorInspectorPlugin


var StringEnumEditor := load("res://addons/string_enum/string_enum_editor.gd")
var StringEnumPlugin := load("res://addons/string_enum/string_enum_plugin.gd")


func _can_handle(object: Object) -> bool:
	return true


## Check if the property is a string and has the correct suffix to be handled by the enum string addon.
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:

	if type != TYPE_STRING or not hint_string or hint_string.is_empty():
		return false
	
	var path_suffixes: String = StringEnumPlugin.setting_string_suffix
	var suffixes: PackedStringArray = ProjectSettings.get_setting(path_suffixes)
	
	if not suffixes or suffixes.is_empty():
		printerr("[Custom Enum] Setting for the string's suffixes is empty!")
		return false
	
	var can_handle := false
	var used_suffix: String
	
	for suffix in suffixes:
		if name.ends_with(suffix):
			can_handle = true
			used_suffix = suffix
			break
	
	if can_handle:
		var names: PackedStringArray = ProjectSettings.get_setting(StringEnumPlugin.setting_string_names.path_join(used_suffix))
		
		add_property_editor(name, StringEnumEditor.new(names))
		
		return true
	
	return false
