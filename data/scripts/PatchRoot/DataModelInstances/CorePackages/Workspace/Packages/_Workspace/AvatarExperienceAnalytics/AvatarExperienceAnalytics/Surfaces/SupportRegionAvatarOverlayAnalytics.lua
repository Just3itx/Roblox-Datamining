-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local _Signals = require(AvatarExperienceAnalyticsParent.Signals)
local SignalsUtils = require(AvatarExperienceAnalyticsParent.SignalsUtils)
local FFlagSplitPaneAvatarMetrics = require(AvatarExperienceAnalyticsParent.SharedFlags).FFlagSplitPaneAvatarMetrics
local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local sendUnifiedEventLog = require(AvatarExperienceAnalytics.sendUnifiedEventLog)
local sendAXCounterV2 = require(AvatarExperienceAnalytics.sendAXCounterV2)
local Constants = require(AvatarExperienceAnalytics.Constants)
local UnifiedEventLogEnums = require(AvatarExperienceAnalytics.UnifiedEventLogEnums)
local UnifiedLoggingElementNameEnums = require(AvatarExperienceAnalytics.Enums.UnifiedLoggingElementNameEnums)

local MarketplaceUnifiedAction = UnifiedEventLogEnums.MarketplaceUnifiedAction

local sessionScopedSignal = nil
local var1 = nil
if FFlagSplitPaneAvatarMetrics then
    sessionScopedSignal, var1 = SignalsUtils.createSessionScopedSignal(false)
end

local tbl1 = {
    unsaved_changes = UnifiedLoggingElementNameEnums.SUPPORT_PANE_UNSAVED_DIALOG,
    no_additional_avatars = UnifiedLoggingElementNameEnums.SUPPORT_PANE_NO_ADDITIONAL_AVATARS_DIALOG
}

local tbl2 = {
    previous = UnifiedLoggingElementNameEnums.SUPPORT_PANE_PREVIOUS_AVATAR_BUTTON,
    next = UnifiedLoggingElementNameEnums.SUPPORT_PANE_NEXT_AVATAR_BUTTON
}

local tbl3 = {
    save = UnifiedLoggingElementNameEnums.SUPPORT_PANE_UNSAVED_DIALOG_SAVE_BUTTON,
    switch_anyway = UnifiedLoggingElementNameEnums.SUPPORT_PANE_UNSAVED_DIALOG_SWITCH_ANYWAY_BUTTON,
    close = UnifiedLoggingElementNameEnums.SUPPORT_PANE_UNSAVED_DIALOG_CLOSE_BUTTON
}

local tbl4 = {
    create_avatar = UnifiedLoggingElementNameEnums.SUPPORT_PANE_NO_ADDITIONAL_AVATARS_DIALOG_CREATE_BUTTON,
    cancel = UnifiedLoggingElementNameEnums.SUPPORT_PANE_NO_ADDITIONAL_AVATARS_DIALOG_CANCEL_BUTTON
}

local function sendUnifiedClick(str1: string, input)
    sendUnifiedEventLog({
        action = MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
        surface = UnifiedLoggingSurface.SUPPORT_PANE_AVATAR_OVERLAY,
        elementName = str1,
        elementMetadata = if input then HttpService:JSONEncode(input) else nil
    })
    if FFlagSplitPaneAvatarMetrics then
        sendAXCounterV2(Constants.AVATAR_EVENT_COUNTER_NAME.SupportRegionAvatarOverlayControlPressed, { control = str1 })
    end
end

local module = {
    Dialog = { UnsavedChanges = "unsaved_changes", NoAdditionalAvatars = "no_additional_avatars" }
}
function module.logDialogShown(str1: string)
    local var2 = tbl1[str1]

    sendUnifiedEventLog({
        action = MarketplaceUnifiedAction.UI_ELEMENT_IMPRESSION,
        surface = UnifiedLoggingSurface.SUPPORT_PANE_AVATAR_OVERLAY,
        elementName = var2
    })
    sendAXCounterV2(Constants.AVATAR_EVENT_COUNTER_NAME.SupportRegionAvatarOverlayDialogShown, { dialog = var2 })
end

function module.logPageView()
    if FFlagSplitPaneAvatarMetrics then
        if sessionScopedSignal(false) then
            return
        end
        var1(true)
        sendAXCounterV2(Constants.AVATAR_EVENT_COUNTER_NAME.SupportRegionAvatarOverlayPageView)
    end
    sendUnifiedEventLog({
        action = MarketplaceUnifiedAction.PAGE_VIEW,
        surface = UnifiedLoggingSurface.SUPPORT_PANE_AVATAR_OVERLAY,
        elementName = UnifiedLoggingElementNameEnums.SUPPORT_PANE_AVATAR_OVERLAY
    })
end

function module.logProfileChipClick()
    sendUnifiedClick(UnifiedLoggingElementNameEnums.SUPPORT_PANE_PROFILE_CHIP)
end

function module.logEditAvatarClick()
    sendUnifiedClick(UnifiedLoggingElementNameEnums.SUPPORT_PANE_EDIT_AVATAR_BUTTON)
end

function module.logChevronClick(direction: string, targetDataReady: boolean)
    sendUnifiedClick(tbl2[direction], { direction = direction, target_data_ready = targetDataReady })
end

function module.logUnsavedDialogClick(str1: string)
    sendUnifiedClick(tbl3[str1])
end

function module.logNoAdditionalAvatarsDialogClick(str1: string)
    sendUnifiedClick(tbl4[str1])
end

return module
