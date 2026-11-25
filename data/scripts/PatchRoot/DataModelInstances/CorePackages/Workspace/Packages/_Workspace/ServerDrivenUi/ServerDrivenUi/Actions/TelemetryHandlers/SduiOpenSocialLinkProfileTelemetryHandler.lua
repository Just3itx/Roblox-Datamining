-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local sendSocialLinkClickEvent = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.sendSocialLinkClickEvent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

local tbl1 = {
    "profileId",
    "profileType",
    "socialLinkType",
    "socialLinkUrl",
    "socialLinkDisplayType"
}
return function(arg1, arg2, arg3)
    local tbl2 = {}
    for _, value in tbl1 do
        if getActionTelemetryFieldValue(arg1, arg2, value) == nil then
            table.insert(tbl2, value)
        end
    end

    if #tbl2 > 0 then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SocialLinkClickTelemetryHandler",
            message = `Missing telemetry fields: {table.concat(tbl2, ", ")}`
        }, arg3.appPage)
    end

    sendSocialLinkClickEvent({
        assignment_id = tonumber(getActionTelemetryFieldValue(arg1, arg2, "profileId", 0)) or 0,
        assignment_type = getActionTelemetryFieldValue(arg1, arg2, "profileType", ""),
        social_link_type = getActionTelemetryFieldValue(arg1, arg2, "socialLinkType", ""),
        social_link_url = getActionTelemetryFieldValue(arg1, arg2, "socialLinkUrl", ""),
        social_link_display_type = getActionTelemetryFieldValue(arg1, arg2, "socialLinkDisplayType", "")
    })
end
