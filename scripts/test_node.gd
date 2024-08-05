extends Node


enum MyEnum
{
	ValueA,
	ValueB,
	ValueC,
}


@export var a: MyEnum
@export var b_ui: String
@export var b_default_suffix: String


func _ready() -> void:	
	print(UiBank.get_scene(b_ui))
	print(b_default_suffix)


