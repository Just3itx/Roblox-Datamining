-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _ApolloClient = require(VirtualEvents.Parent.ApolloClient)
local RetrievalStatus = require(VirtualEvents.Parent.Http).Enum.RetrievalStatus

local function getRetrievalStatusFromApolloQuery(arg1)
    if arg1.loading then
        return RetrievalStatus.Fetching
    end

    if arg1.data then
        return RetrievalStatus.Done
    end

    if arg1.error then
        return RetrievalStatus.Failed
    end

    return RetrievalStatus.NotStarted
end

return getRetrievalStatusFromApolloQuery
