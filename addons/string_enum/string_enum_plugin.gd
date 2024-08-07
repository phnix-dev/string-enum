@tool
extends EditorPlugin


const ADDON_NAME := "Create String Enum From Folder"
const ADDON_PATH := "addons/string_enum/"
const DEFAULT_SUFFIX := "_default_suffix"
const PATH_INSPECTOR: Script = preload("res://addons/string_enum/string_enum_inspector.gd")
const PATH_SCENE_TOOL: PackedScene = preload("res://addons/string_enum/string_enum_tool.tscn")

static var setting_string_tool := ADDON_PATH.path_join("tools/enable_auto_tool")
static var setting_string_suffix := ADDON_PATH.path_join("string_suffixes")
static var setting_string_names := ADDON_PATH.path_join("string_names")

var inspector: EditorInspectorPlugin


func _enter_tree() -> void:
	inspector = PATH_INSPECTOR.new()
	
	_create_setting_bool(setting_string_tool, true)
	
	if _create_setting_packed_str(setting_string_suffix, PackedStringArray([DEFAULT_SUFFIX])):
		_create_setting_packed_str(setting_string_names.path_join(DEFAULT_SUFFIX), PackedStringArray())
	
	add_inspector_plugin(inspector)
	
	if ProjectSettings.get_setting(setting_string_tool, false):
		add_tool_menu_item(ADDON_NAME, _create_enums_from_folder)


func _exit_tree() -> void:
	remove_inspector_plugin(inspector)
	remove_tool_menu_item(ADDON_NAME)


func _create_enums_from_folder() -> void:
	var scene = PATH_SCENE_TOOL.instantiate()
	
	add_child(scene)


func _create_setting_bool(setting_name: String, value: bool) -> bool:
	if not ProjectSettings.has_setting(setting_name):
		var property_info := {
			"name": setting_name,
			"type": TYPE_BOOL,
		}
		
		ProjectSettings.set_setting(setting_name, value)
		ProjectSettings.add_property_info(property_info)
		
		return true
	
	return false


func _create_setting_packed_str(setting_name: String, arr: PackedStringArray) -> bool:
	if not ProjectSettings.has_setting(setting_name):
		var property_info := {
			"name": setting_name,
			"type": TYPE_PACKED_STRING_ARRAY,
		}
		
		ProjectSettings.set_setting(setting_name, arr)
		ProjectSettings.add_property_info(property_info)
		
		return true
	
	return false
