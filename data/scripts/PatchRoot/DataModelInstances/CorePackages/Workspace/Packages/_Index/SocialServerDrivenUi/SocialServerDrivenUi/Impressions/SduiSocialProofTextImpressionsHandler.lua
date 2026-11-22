-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local SduiErrors = require(SocialServerDrivenUiParent.SduiCoreSystem).SduiErrors
local _UnifiedLogging = require(SocialServerDrivenUiParent.UnifiedLogging)

local FFlagSduiSocialProofTextAnalytics = require(SocialServerDrivenUi.Flags.FFlagSduiSocialProofTextAnalytics)

local buildSocialProofTextEventParams = require(SocialServerDrivenUi.Analytics.SocialProofText.buildSocialProofTextEventParams)

local sendSocialProofTextImpressionEvent = require(SocialServerDrivenUi.Analytics.SocialProofText.sendSocialProofTextImpressionEvent)

local function SduiSocialProofTextImpressionsHandler(arg1, tbl1, tbl2, _, _: number?)
    if not FFlagSduiSocialProofTextAnalytics then
        return
    end

    for _, value in tbl1 do
        local var1 = tbl2[value] or nil
        local socialProofTextEventParams = if var1 then buildSocialProofTextEventParams({
            universeId = var1.universeId,
            placeId = var1.placeId,
            totalConnections = var1.totalConnections,
            users = var1.connectionPlayedUsers,
            avatarMax = var1.avatarMax,
            page = arg1.appPage
        }) else nil

        if socialProofTextEventParams then
            sendSocialProofTextImpressionEvent(socialProofTextEventParams)
        else
            arg1.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogSocialProofTextImpressions, {
                name = "SduiSocialProofTextImpressionsHandler",
                message = `Missing universeId for impression index {value}`
            }, arg1.appPage)
        end
    end
end

return SduiSocialProofTextImpressionsHandler
