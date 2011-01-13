Oberon Templates. Copyright (c) Alexander Iljin, 2011.

Table of contents (listed alphabetically):
0 General idea
1 Implementation
Stack template

0 General idea

The general idea of the template engine is to provide parameterized modules, which can be instantiated by a project's make system. For example, if you happen to need a stack implementation holding objects of some type, you can write that from scratch, or you can create an abstract stack implementation, and then extend it to support the type of content you need, or you can use a template to quickly generate the required module. The template will help you with the latter.

1 Implementation

For this template generator to work you'll need the cmd.exe interpreter and the GNU Sed utility available on your PATH.

Stack template

Parameters:
ModuleName - identifier to be used as the generated module name.
Import - full IMPORT section of the generated module (set empty if not used).
ItemType - identifier of the type to be stored in the stack.

Example:
ot Stack "ModuleName=ModuleStack" "Import=IMPORT Project;" "ItemType=Project.Module" >ModuleStack.ob2

Description:
The Stack template generates a module with the exported abstract Stack type and hidden implementation. Simple operations, such as New, Push, Pop, Size and others are provided. The stack object is capable of holding items of a given type (see the ItemType parameter). The item type can be a simple built-in type or a pointer type.
