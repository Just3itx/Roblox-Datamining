-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local createIndividualBodyPartSchema = require(scriptParentParent.util.createIndividualBodyPartSchema)

local function createDynamicHeadMeshPartSchema(arg1)
    local individualBodyPartSchema = createIndividualBodyPartSchema(Enum.AssetType.DynamicHead, "Head", arg1)

    table.insert(individualBodyPartSchema._children, { Name = { "FaceControls" }, ClassName = "FaceControls" })

    return individualBodyPartSchema
end

return createDynamicHeadMeshPartSchema
