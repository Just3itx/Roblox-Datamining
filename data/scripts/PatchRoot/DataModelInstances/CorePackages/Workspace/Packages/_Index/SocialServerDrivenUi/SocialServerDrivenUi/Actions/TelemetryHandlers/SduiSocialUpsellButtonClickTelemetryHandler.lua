-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SocialLuaAnalytics = require(SocialServerDrivenUiParent.SocialLuaAnalytics)
local SocialUpsell = require(SocialServerDrivenUiParent.SocialUpsell)

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue
local EventTypes = SocialLuaAnalytics.Analytics.Enums.EventTypes
local SocialUpsellAnalytics = SocialUpsell.Analytics.SocialUpsellAnalytics

local tbl1 = { "upsellEntrySurface", "upsellComponent", "upsellPurpose" }

local function SduiSocialUpsellButtonClickTelemetryHandler(arg1, arg2, arg3)
    local tbl2 = {}
    local tbl3 = ({})
    for _, value in tbl1 do
        local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, value)
        tbl3[value] = actionTelemetryFieldValue
        if actionTelemetryFieldValue == nil then
            table.insert(tbl2, value)
        end
    end

    if #tbl2 > 0 then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SocialUpsellButtonClickTelemetryHandler",
            message = `Missing telemetry fields: {table.concat(tbl2, ", ")}`
        }, arg3.appPage)
    end

    SocialUpsellAnalytics.logUpsellEvent(EventTypes.SocialUpsellButtonClick, {
        upsellEntrySurface = tbl3.upsellEntrySurface,
        upsellComponent = tbl3.upsellComponent,
        upsellPurpose = tbl3.upsellPurpose,
        upsellStage = getActionTelemetryFieldValue(arg1, arg2, "upsellStage"),
        upsellImpressionId = getActionTelemetryFieldValue(arg1, arg2, "upsellImpressionId"),
        btn = getActionTelemetryFieldValue(arg1, arg2, "btn"),
        conversationId = getActionTelemetryFieldValue(arg1, arg2, "conversationId"),
        upsellEntryComponent = getActionTelemetryFieldValue(arg1, arg2, "upsellEntryComponent")
    })
end

return SduiSocialUpsellButtonClickTelemetryHandler
