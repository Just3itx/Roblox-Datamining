-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local getFStringUGCLCAllowedAssetTypeIds = require(scriptParentParent.flags.getFStringUGCLCAllowedAssetTypeIds)

local module = {}

function module.isRigidAccessoryAllowed(arg1): boolean
    local var1 = Constants.ASSET_TYPE_INFO[arg1]
    return not (var1 == nil) and var1.rigidAllowed == true
end

function module.isLayeredClothingAllowed(arg1): boolean
    return table.find(string.split(getFStringUGCLCAllowedAssetTypeIds(), ","), tostring(arg1.Value)) ~= nil
end

return module
