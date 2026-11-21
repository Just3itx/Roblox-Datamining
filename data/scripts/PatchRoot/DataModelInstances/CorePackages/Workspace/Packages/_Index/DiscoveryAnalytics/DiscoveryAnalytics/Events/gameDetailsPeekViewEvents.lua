-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local ArgCheck = require(DiscoveryAnalyticsParent.ArgCheck)
local FFlagLuaAppEdpBottomSheetPeekViewEvents = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppEdpBottomSheetPeekViewEvents

return function(arg1, arg2, universeId, source, index, surface: string?)
    ArgCheck.isType(arg2, "string", "eventName")
    ArgCheck.isType(universeId, "string", "universeId")
    ArgCheck.isType(source, "string", "source")
    ArgCheck.isType(index, "number", "index")
    if FFlagLuaAppEdpBottomSheetPeekViewEvents and surface ~= nil then
        ArgCheck.isType(surface, "string", "surface")
    end

    if not Players.LocalPlayer then
        return
    end

    local userId = Players.LocalPlayer.UserId

    local str2 = "GameDetailsPeekView"
    local tbl1 = {
        uid = tostring(userId),
        locale = LocalizationService.RobloxLocaleId,
        universeId = universeId,
        source = source,
        index = index,
        surface = 0
    }

    if not FFlagLuaAppEdpBottomSheetPeekViewEvents then
        surface = nil
    end

    tbl1.surface = surface
    arg1:setRBXEventStream(str2, arg2, tbl1)
end
