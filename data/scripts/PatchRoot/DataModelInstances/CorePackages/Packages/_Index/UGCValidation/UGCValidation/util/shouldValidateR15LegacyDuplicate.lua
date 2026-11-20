-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.util.Types)

local function shouldValidateR15LegacyDuplicate(arg1): boolean
    if not (arg1 and arg1.consumerConfig and arg1.consumerConfig.enforceR15FolderStructure) then
        return false
    end

    local uploadEnum = arg1.uploadEnum
    if uploadEnum.bundleType == Enum.BundleType.BodyParts then
        return true
    end

    local assetType = uploadEnum.assetType
    return not (assetType == nil) and Constants.AssetUploadsWithFolderStructure[assetType] == true
end

return shouldValidateR15LegacyDuplicate
