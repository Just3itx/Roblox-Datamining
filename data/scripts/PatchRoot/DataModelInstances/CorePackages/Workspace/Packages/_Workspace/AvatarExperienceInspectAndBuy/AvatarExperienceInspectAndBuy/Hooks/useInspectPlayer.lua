-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local useSelector = require(AvatarExperienceInspectAndBuyParent.RoactUtils).Hooks.RoactRodux.useSelector
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)
local Players = game:GetService("Players")
local UserLib = require(AvatarExperienceInspectAndBuyParent.UserLib)

local function selectPlayer(arg1)
    return {
        playerName = arg1.playerName,
        playerId = arg1.playerId
    }
end

return function()
    local var1 = useSelector(selectPlayer, tutils.deepEqual)
    local playerName = if var1 then var1.playerName else nil
    local var2 = if var1 then tonumber(var1.playerId) else nil
    local playerByUserId = var2 and Players:GetPlayerByUserId(var2)

    return {
        playerName = playerName,
        playerId = var2,
        hasVerifiedBadge = if playerByUserId then UserLib.Utils.isPlayerVerified(playerByUserId) else false
    }
end
