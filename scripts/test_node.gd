# ╔═════════════════════════════════════════════════════════════════════╗
# ║ This file is licensed under the Mozilla Public License Version 2.0. ║
# ╚═════════════════════════════════════════════════════════════════════╝

extends Node


@warning_ignore("unused_signal")
signal state_changed(previous, new)

const ANSWER = 42
const OTHER_ANSWER = 8
const SOME_ANSWER = 76195

enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
enum {FIRE, WATER, AIR}
enum Named {THING_1, THING_2, ANOTHER_THING = -1}
enum MyEnum
{
	ValueA,
	ValueB,
	ValueC,
}

@export var initial_state: Node
@export var dictionary = {
	"_int": 50,
	"_float": 50.0,
	"_string": "50",
	"_object": Object.new(),
}

@warning_ignore("unused_private_class_variable")
@onready var _state_name = 5

var other_int = 5
var vector3 = Vector3(1, 2, 3)
var is_active = true

@export var a: MyEnum
@export var b_ui: String
@export var b_default_suffix: String
@export var default_MyEnum: String
@export var c__d_MyEnum: String
@export var a_b__c_MyEnum: String
@export var _MyEnum: String
