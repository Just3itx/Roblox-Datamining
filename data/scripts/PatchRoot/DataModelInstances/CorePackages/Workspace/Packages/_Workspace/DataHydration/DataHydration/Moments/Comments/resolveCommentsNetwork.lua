-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Players = game:GetService("Players")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local SharedFlags = require(DataHydrationParent.SharedFlags)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)

local FFlagMomentsCommentsUseMockNetwork = SharedFlags.FFlagMomentsCommentsUseMockNetwork
local bool1 = game:DefineFastFlag("MomentsCommentsMockLatency", false)
local bool2 = game:DefineFastFlag("MomentsCommentsMockPostedViewer", false)
local var1 = nil
if FFlagMomentsCommentsUseMockNetwork then
    local createCommentsMockNetwork = require(script.Parent.createCommentsMockNetwork)
    local localPlayer = Players.LocalPlayer
    local tbl1 = {
        fetchLatencySeconds = if bool1 then 0.2 else nil,
        postLatencySeconds = if bool1 then 2 else nil,
        postAuthorUserId = if bool2 and localPlayer ~= nil and localPlayer.UserId > 0 then tostring(localPlayer.UserId) else nil
    }
    var1 = createCommentsMockNetwork(tbl1)
end

local function resolveCommentsNetwork(arg1)
    return if FFlagMomentsCommentsUseMockNetwork then var1 elseif arg1 == nil then nil else arg1.network
end

return resolveCommentsNetwork
