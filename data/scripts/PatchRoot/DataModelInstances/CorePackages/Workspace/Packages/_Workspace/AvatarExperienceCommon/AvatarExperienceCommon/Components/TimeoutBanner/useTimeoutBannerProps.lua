-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local useSignalState = require(AvatarExperienceCommonParent.SignalsReact).useSignalState
local useLocalization = require(AvatarExperienceCommonParent.Localization).Hooks.useLocalization
local useNavigation = require(AvatarExperienceCommonParent.Navigation).useNavigation
local AvatarScreen = require(AvatarExperienceCommonParent.AvatarExperienceNavigation).Enums.AvatarScreen

local getTimeoutStatusStore = require(AvatarExperienceCommon.Stores.TimeoutStatusStore.getTimeoutStatusStore)
local formatTimeoutEndTime = require(AvatarExperienceCommon.Utils.formatTimeoutEndTime)
local useIsAvatarChangeTimeoutActive = require(AvatarExperienceCommon.Hooks.useIsAvatarChangeTimeoutActive)
local showAvatarChangeFeatureRestriction = require(AvatarExperienceCommon.Utils.showAvatarChangeFeatureRestriction)

local FFlagAXUseUFRForTimeoutPromptInApp = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXUseUFRForTimeoutPromptInApp
local FFlagAXTimeoutAcknowledgementGating = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXTimeoutAcknowledgementGating

local function useTimeoutBannerProps(tbl1)
    local shouldFetch = if tbl1 and tbl1.shouldFetch ~= nil then tbl1.shouldFetch else false
    local var1 = not tbl1 or tbl1.shouldNavigateOnClick == nil or tbl1.shouldNavigateOnClick

    local timeoutStatusStore = getTimeoutStatusStore()
    local var2 = useSignalState(timeoutStatusStore.getStatus)
    local var3 = useSignalState(timeoutStatusStore.getIsTimedOut)
    local var4 = useNavigation()

    React.useEffect(function()
        if shouldFetch then
            timeoutStatusStore.fetchStatus()
        end
    end, { shouldFetch, timeoutStatusStore })

    local var5 = var2.timeoutAction and var2.timeoutAction.endTime or var2.details and var2.details.endDate
    local time = formatTimeoutEndTime(var5)

    local var7 = useLocalization({
        messageText = time and { "Feature.Timeout.WarningBanner.DisabledUntilMessage", time = time }
            or "Feature.Timeout.WarningBanner.DisabledMessage"
    })

    local var8 = React.useCallback(function()
        var4.navigate(AvatarScreen.TimeoutStatusPrompt)
    end, { var4 })

    if FFlagAXTimeoutAcknowledgementGating then
        local var9 = useIsAvatarChangeTimeoutActive()
        var3 = var3 and var9
    end

    if FFlagAXUseUFRForTimeoutPromptInApp then
        return {
            messageText = var7.messageText,
            onBannerActivated = if var1 then showAvatarChangeFeatureRestriction else nil,
            shouldShow = var3
        }
    end

    local tbl2 = {
        messageText = var7.messageText,
        onBannerActivated = 0,
        shouldShow = 0
    }

    if not var1 then
        var8 = nil
    end

    tbl2.onBannerActivated = var8
    tbl2.shouldShow = var3
    return tbl2
end

return useTimeoutBannerProps
