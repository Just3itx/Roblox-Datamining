-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local _Types = require(scriptParentParent.util.Types)
local createIndividualBodyPartSchema = require(scriptParentParent.util.createIndividualBodyPartSchema)

local function createLimbsAndTorsoSchema(arg1, str1: string, arg2)
    local var1 = Constants.ASSET_TYPE_INFO[arg1]

    local tbl1 = {
        ClassName = "Folder",
        Name = { str1 },
        _children = {}
    }

    for k in pairs(var1.subParts) do
        local individualBodyPartSchema = createIndividualBodyPartSchema(arg1, k, arg2)
        table.insert(tbl1._children, individualBodyPartSchema)
    end
    return tbl1
end

return createLimbsAndTorsoSchema
