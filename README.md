# String Enum - Godot Addon

This addon enables string to be used as an enum value.

### 1.0.0 UPDATE

The addon uses enums in the script instead of the having the enum values stored in the project settings! Making it much easier to use.

## Problems with standard enums

When exporting a variable where its type is an enum (to edit it in the inspector), the value stored in the scene is just a number, which can cause problems when adding or removing values of the enum.

### Example

If you have an enum (MyEnum) with three values (ValueA, ValueB, ValueC) and in the inspector you set the exported enum to `ValueB`, it's not really `ValueB` that is saved, it is 1 because enums are just numbers (ValueA = 0, ValueB = 1, ValueC = 2).

So, if you remove `ValueA` because you don't need it anymore, the value in the inspector will not be `ValueB` but `ValueC` because now `ValueC` equals 1.

It would be nice to have enums store the actual name of the enum value instead of a number, that's what this addon does.

## Installation

1. Download the addon from GitHub or AssetLib.
2. Copy the addons folder into your project if you download it from GitHub.
3. Enable the addons in your project settings.

## Usage (1.0.0 UPDATE)

- Create an Enum 
- Create an exported String
- Add an underscore and the name of the enum at the end
- The values will be shown in the inspector
- After selecting a value, it will be saved as a string in the scene file and accessible in the exported String

```
enum MyEnum { VALUE_0, VALUE_1, ... }

@export var my_string_MyEnum: String
```

### Using the `Create Enum From Folder` tool

This tool takes all the files in a folder then converts the file names to an enum.

- Click on the `Project > Tools > Create Enum From Folder` button.
- Enter the enum name (The name is automatically capitalized).
- Select the folder containing the files to be used as enum values.
- Click the Generate button.
- If all goes well, you will see a message in the Output panel (The enum is stored on your clipboard)

### Examples

- You can check the `res://scripts/test_node.gd` script to see an example of the string enum at work.
- You can check the `res://scripts/ui_bank.gd` script to see how to easily retrieve scenes at runtime.
- You can check the `res://scenes/test_node.tscn` scene data to see how the values are stored.

## License

This project is licensed under the terms of the [Mozilla Public License, version 2.0](https://www.mozilla.org/en-US/MPL/2.0/).
