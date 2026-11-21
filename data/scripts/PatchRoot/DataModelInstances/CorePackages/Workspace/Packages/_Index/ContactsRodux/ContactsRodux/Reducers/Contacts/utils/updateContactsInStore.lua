-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Types = scriptParentParentParentParent.Types
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local _ActionTypes = require(Types.ActionTypes)
local _ReducerTypes = require(Types.ReducerTypes)
local Dash = require(scriptParentParentParentParentParent.Dash)

return function(arg1, arg2)
    local userContactsEntities = arg2.responseBody.userContactsEntities
    local tbl1 = {}

    Dash.forEach(userContactsEntities, function(arg3)
        tbl1[arg3.id] = {
            contactName = arg3.name,
            mutualContacts = arg3.mutualContacts,
            avatarAssetHashId = arg3.avatarAssetHashId,
            headshotThumbnailUrl = arg3.headshotThumbnailUrl,
            avatarThumbnailUrl = arg3.avatarThumbnailUrl
        }
    end)

    return Dash.join(arg1, tbl1)
end
