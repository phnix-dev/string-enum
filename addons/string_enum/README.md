# String Enum - Godot Addon

This addon enable string to be used as enum values.

## Problems with standard enums

When exporting a variable where its type is a enum (to edit it in the inspector), the value stored in the scene is just a number, which can cause problems when adding or removing values of the enum.

### Example

If you have an enum (MyEnum) with three values (ValueA, ValueB, ValueC) and in the inspector you set the exported enum to `ValueB`, it's not really `ValueB` that is saved, it is 1 because enums are just numbers (ValueA = 0, ValueB = 1, ValueC = 2).

So if you remove `ValueA` because you don't need it anymore, the value in the inspector will not be `ValueB` but `ValueC` because now `ValueC` equals 1.

It would be nice to have enums store the actual name of the enum value instead of a number, that's what this addon does.

## Installation

1. Download the addon from GitHub or AssetLib.
2. Copy the addons folder into your project if you downloaded it from GitHub.
3. Enable the addons in your project settings.

## Usage

### Creating the enum manualy

Firstly, to tell the addon that you want a particular string to be treated as an enum, you need to add a suffix to the variable and add a suffix (`_my_suffix`) to the array (`Addons > String Enum > String Suffixes`) in the Project Settings.

Second, create a new setting value of type PackedStringArray in the path `addons/string_enum/string_names/_my_suffix` (you can change `_my_suffix` to whatever you need, but it must be the same as the value entered in the `String Suffixes` array). Then add any enum values you need. If your variable is a string and its name ends with the suffix, you will see a list of enum values to choose from, like with normal enums.

### Using the `Create String Enum From Folder` tool

*This tool was created to access scenes more easily (Because I cannot @export PackedScene as they create cyclic errors and if I @export_file a scene, it is not updated when moving the scene file in the FileSystem).*

- Click on the `Project > Tools > Create String Enum From Folder` button.
- Enter a suffix (an underscore is added automatically).
- Select the folder where the scenes are to be used as enum values.
- Click the Generate button.
- If all goes well, you will see the following printed out, confirming what you have entered.

### Examples

You can check the `res://scripts/test_node.gd` script to see an example of the string enum at work.
You can check the `res://scripts/ui_bank.gd` script to see how to easily retrieve scenes at runtime.
You can check the `res://scenes/test_node.tscn` scene data to see how the values are stored.

## License

This project is licensed under the terms of the [Mozilla Public License, version 2.0](https://www.mozilla.org/en-US/MPL/2.0/).
