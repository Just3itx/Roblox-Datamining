-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local SafetyResourceBannerAction = DiscoveryAnalytics.Constants.SafetyResourceBannerAction
local sendSafetyResourceBannerEvent = DiscoveryAnalytics.Events.sendSafetyResourceBannerEvent

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local function SduiSafetyResourceBannerImpressionsHandler(_, tbl1, tbl2, _, _: number?)
    for _, value in tbl1 do
        local var1 = not tbl2 and {} or tbl2[value] or {}

        sendSafetyResourceBannerEvent({
            action = SafetyResourceBannerAction.Impression,
            moderationCategory = var1.moderationCategory,
            url = var1.url,
            surface = var1.surface,
            textFilterRequestId = var1.textFilterRequestId
        })
    end
end

return SduiSafetyResourceBannerImpressionsHandler
