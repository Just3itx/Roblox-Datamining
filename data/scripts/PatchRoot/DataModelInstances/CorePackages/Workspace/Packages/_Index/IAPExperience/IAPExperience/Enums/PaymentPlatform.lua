-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local addRawValueMethodToEnum = require(scriptParentParent.Utility.addRawValueMethodToEnum)

local tbl1 = {
    None = "None",
    Apple = "Apple",
    Google = "Google",
    Amazon = "Amazon",
    Xbox = "Xbox",
    UWP = "UWP",
    Web = "Web",
    Maquettes = "Maquettes",
    Palisades = "Palisades"
}
local var1 = require(scriptParentParentParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1
