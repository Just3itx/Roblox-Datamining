-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local FFlagProfileTradeItemsExposureLogging = require(ProfilePlatform.Flags.FFlagProfileTradeItemsExposureLogging)
local FStringProfileTradeItemsIxpLayer = require(ProfilePlatform.Flags.FStringProfileTradeItemsIxpLayer)

local function logTradeItemsExposureIfEligible(tbl1)
    if not FFlagProfileTradeItemsExposureLogging
        or tostring(tbl1.profileId) == tostring(tbl1.localUserId)
        or not tbl1.localHasPaidTradingAccess
        or not tbl1.otherHasPaidTradingAccess
    then
        return
    end

    local var1 = FStringProfileTradeItemsIxpLayer
    if var1 == "" then
        return
    end

    local ixpService = tbl1.ixpService
    if ixpService == nil then
        if not game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
            return
        end
        ixpService = game:GetService("IXPService")
    end

    assert(ixpService ~= nil, "IXPService is required to log layer exposure")

    pcall(function()
        ixpService:LogFlagLinkedUserLayerExposure(var1)
    end)
end

return logTradeItemsExposureIfEligible
