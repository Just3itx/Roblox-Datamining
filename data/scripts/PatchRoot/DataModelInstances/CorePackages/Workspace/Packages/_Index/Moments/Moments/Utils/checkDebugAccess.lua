-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local Moments = script:FindFirstAncestor("Moments")

local GetFStringMomentsDebugModeAllowList = require(Moments.Flags.GetFStringMomentsDebugModeAllowList)
local parseUserAllowList = require(Moments.Utils.parseUserAllowList)

local function checkDebugAccess()
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return false
    end

    return parseUserAllowList(GetFStringMomentsDebugModeAllowList(), localPlayer.UserId)
end

return checkDebugAccess
