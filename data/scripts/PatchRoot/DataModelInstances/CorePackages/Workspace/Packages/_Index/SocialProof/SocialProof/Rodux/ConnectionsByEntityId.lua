-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent
local Rodux = require(SocialProofParent.Rodux)
local Cryo = require(SocialProofParent.Cryo)
local NetworkingSocialProof = require(SocialProof.Networking.NetworkingSocialProof)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[NetworkingSocialProof.GetConnectionsByEntityId.Succeeded.name] = function(arg1, arg2)
    local tbl2 = ({})
    local connections = arg2.responseBody.connections
    local totalCount = arg2.responseBody.totalCount
    local entityId = arg2.postBody.entityId
    local entityType = arg2.postBody.entityType
    local connectionType = arg2.postBody.connectionType

    if not tbl2[connectionType] then
        tbl2[connectionType] = {}
    end
    if not tbl2[connectionType][entityType] then
        tbl2[connectionType][entityType] = {}
    end

    local userIds = not connections and {} or Cryo.List.map(connections, function(arg3): string
        return tostring(arg3.id)
    end)

    tbl2[connectionType][entityType][entityId] = {
        totalConnections = totalCount,
        userIds = userIds
    }

    return Cryo.Dictionary.union(arg1, tbl2)
end

return createReducer({}, tbl1)
