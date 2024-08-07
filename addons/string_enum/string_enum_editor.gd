extends EditorProperty


const NULL_VALUE := "none"

var is_updating := false
var current_string: String = NULL_VALUE
var property_control := OptionButton.new()


## Create the OptionButton and init the item.
func _init(names: Array[String]) -> void:
	property_control.add_item(NULL_VALUE)
	
	for item_name in names:
		property_control.add_item(item_name)
	
	add_child(property_control)
	add_focusable(property_control)
	
	property_control.item_selected.connect(_on_property_control_item_selected)


## The internal string is updated when a OptionButton.item is selected.
func _on_property_control_item_selected(index: int) -> void:
	if is_updating:
		return
	
	current_string = property_control.get_item_text(index)

	emit_changed(get_edited_property(), current_string)


## Set the correct item based on the existing value in the editor.
func _update_property() -> void:
	var edited_object := get_edited_object()
	var edited_property := get_edited_property()
	var editor_value = edited_object[edited_property]
	
	if property_control.selected == -1 or editor_value == current_string:
		return
	
	is_updating = true
	current_string = editor_value
	var not_found := true
	
	for idx in property_control.item_count:
		if property_control.get_item_text(idx) == current_string:
			property_control.select(idx)
			not_found = false
			break
	
	if not_found:
		current_string = NULL_VALUE
		property_control.select(0)
		emit_changed(get_edited_property(), current_string)
		
	is_updating = false
