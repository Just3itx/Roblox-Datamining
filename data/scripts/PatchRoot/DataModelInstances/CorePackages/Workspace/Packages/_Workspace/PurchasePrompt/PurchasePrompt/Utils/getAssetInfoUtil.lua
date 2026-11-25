-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local isCreatorStoreAssetType = require(scriptParentParent.Utils.isCreatorStoreAssetType)
local _Promise = require(scriptParentParent.Promise)

local module = {}

function module.isAssetValid(arg1): boolean
    return not not (not isCreatorStoreAssetType(arg1.type) or arg1.id and arg1.type and arg1.typeId and arg1.creator)
end

function module.fromAsset(arg1)
    return {
        id = arg1.id,
        type = arg1.type,
        typeId = arg1.typeId,
        creator = arg1.creator,
        description = arg1.description,
        isPublicDomainEnabled = arg1.isPublicDomainEnabled,
        name = arg1.name
    }
end
return module
