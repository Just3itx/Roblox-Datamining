-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

local FFlagSduiSocialProofTextAnalytics = require(SocialServerDrivenUi.Flags.FFlagSduiSocialProofTextAnalytics)

local buildSocialProofTextEventParams = require(SocialServerDrivenUi.Analytics.SocialProofText.buildSocialProofTextEventParams)

local sendSocialProofTextClickedEvent = require(SocialServerDrivenUi.Analytics.SocialProofText.sendSocialProofTextClickedEvent)

local function SduiSocialProofTextClickTelemetryHandler(arg1, arg2, arg3)
    if not FFlagSduiSocialProofTextAnalytics then
        return
    end

    local socialProofTextEventParams = buildSocialProofTextEventParams({
        universeId = getActionTelemetryFieldValue(arg1, arg2, "universeId"),
        placeId = getActionTelemetryFieldValue(arg1, arg2, "placeId"),
        totalConnections = getActionTelemetryFieldValue(arg1, arg2, "totalConnections"),
        users = arg1 and arg1.actionParams and arg1.actionParams.userIds,
        avatarMax = getActionTelemetryFieldValue(arg1, arg2, "avatarMax"),
        page = arg3.appPage
    })

    if socialProofTextEventParams == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { message = "SocialProofTextClick telemetry missing `universeId`" },
            arg3.appPage
        )
        return
    end

    sendSocialProofTextClickedEvent(socialProofTextEventParams)
end

return SduiSocialProofTextClickTelemetryHandler
