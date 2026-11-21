-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local AvatarExperienceAnalytics = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceAnalytics)
local AvatarExperienceNavigation = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceNavigation)
local SharedFlags = require(AvatarExperienceProfilePictureEditorParent.SharedFlags)

local sendUnifiedEventLog = AvatarExperienceAnalytics.sendUnifiedEventLog
local sendAXCounterV2 = AvatarExperienceAnalytics.sendAXCounterV2
local reportAvatarEventCounterV1 = AvatarExperienceAnalytics.reportAvatarEventCounterV1
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedLoggingElementNameEnums = AvatarExperienceAnalytics.Enums.UnifiedLoggingElementNameEnums
local UnifiedLoggingSurface = AvatarExperienceNavigation.Enums.UnifiedLoggingSurface
local Constants = AvatarExperienceAnalytics.Constants
local AvatarExperienceFlags = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceFlags)

local FFlagEditProfileImageV2Telemetry = SharedFlags.FFlagEditProfileImageV2Telemetry
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

local module = {}

local tbl1 = { confirm = "R15_UPGRADE_CONFIRM", cancel = "R15_UPGRADE_CANCEL" }

local function buildSaveElementMetadata(tbl2): string
    local input = {
        mode = tbl2.mode,
        is_plus_subscriber = tostring(tbl2.isPlusSubscriber)
    }

    if tbl2.emoteAssetId ~= nil then
        input.emote_asset_id = tbl2.emoteAssetId
    end

    if tbl2.frameAssetId ~= nil then
        input.frame_asset_id = tostring(tbl2.frameAssetId)
    end

    return HttpService:JSONEncode(input)
end

local function buildSubscribeElementMetadata(tbl2): string
    local input = {
        mode = tbl2.mode,
        purchase_flow_uuid = tbl2.purchaseFlowUuid,
        source = tbl2.source
    }

    if tbl2.frameAssetId ~= nil then
        input.frame_asset_id = tostring(tbl2.frameAssetId)
    end

    return HttpService:JSONEncode(input)
end

function module.logPageView(tbl2)
    if not FFlagEditProfileImageV2Telemetry then
        return
    end

    sendUnifiedEventLog({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.PAGE_VIEW,
        surface = UnifiedLoggingSurface.EDIT_PROFILE_IMAGE,
        elementName = if FFlagAXUnifiedEventStrictPayloads then UnifiedLoggingElementNameEnums.EDIT_PROFILE_IMAGE else nil,
        elementMetadata = HttpService:JSONEncode({ mode = tbl2.mode })
    })

    sendAXCounterV2("EditProfileImagePageView", { mode = tbl2.mode })
end

function module.logSave(tbl2)
    if not FFlagEditProfileImageV2Telemetry then
        return
    end

    sendAXCounterV2("EditProfileImageSave", {
        mode = tbl2.mode,
        is_plus_subscriber = if tbl2.isPlusSubscriber then "true" else "false",
        result = tostring(tbl2.result)
    })

    if tbl2.result ~= "success" then
        return
    end

    sendUnifiedEventLog({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
        surface = UnifiedLoggingSurface.EDIT_PROFILE_IMAGE,
        elementName = "SAVE",
        elementMetadata = buildSaveElementMetadata(tbl2)
    })

    reportAvatarEventCounterV1(Constants.AVATAR_EVENT_COUNTER_NAME.AXUpdateProfilePicture)
end

function module.logSubscribe(tbl2)
    if not FFlagEditProfileImageV2Telemetry then
        return
    end

    sendUnifiedEventLog({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
        surface = UnifiedLoggingSurface.EDIT_PROFILE_IMAGE,
        elementName = "SUBSCRIBE",
        elementMetadata = buildSubscribeElementMetadata(tbl2)
    })

    sendAXCounterV2("EditProfileImageSubscribe", { mode = tbl2.mode, source = tostring(tbl2.source) })
end

function module.logClose(tbl2)
    if not FFlagEditProfileImageV2Telemetry then
        return
    end

    sendUnifiedEventLog({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
        surface = UnifiedLoggingSurface.EDIT_PROFILE_IMAGE,
        elementName = "CLOSE",
        elementMetadata = HttpService:JSONEncode({ mode = tbl2.mode, active_view = tbl2.activeView })
    })

    sendAXCounterV2("EditProfileImageClose", { mode = tbl2.mode })
end

function module.logBack(tbl2)
    if not FFlagEditProfileImageV2Telemetry then
        return
    end

    sendUnifiedEventLog({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
        surface = UnifiedLoggingSurface.EDIT_PROFILE_IMAGE,
        elementName = "BACK",
        elementMetadata = HttpService:JSONEncode({ mode = tbl2.mode, active_view = tbl2.activeView, outcome = tbl2.outcome })
    })

    sendAXCounterV2("EditProfileImageBack", { mode = tbl2.mode, outcome = tostring(tbl2.outcome) })
end

function module.logFetchFailure(tbl2)
    if not FFlagEditProfileImageV2Telemetry then
        return
    end

    sendAXCounterV2("EditProfileImageFetchFailure", { asset_type = tostring(tbl2.assetType) })
end

function module.logRetry(tbl2)
    if not FFlagEditProfileImageV2Telemetry then
        return
    end

    sendAXCounterV2("EditProfileImageRetry", { mode = tbl2.mode, asset_type = tostring(tbl2.assetType) })
end

function module.logR15UpgradePromptShown()
    sendUnifiedEventLog({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_IMPRESSION,
        surface = UnifiedLoggingSurface.EDIT_PROFILE_IMAGE,
        elementName = "R15_UPGRADE_PROMPT"
    })

    sendAXCounterV2("EditProfileImageR15UpgradePromptShown")
end

function module.logR15UpgradePromptInteraction(str1: string)
    sendUnifiedEventLog({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
        surface = UnifiedLoggingSurface.EDIT_PROFILE_IMAGE,
        elementName = tbl1[str1]
    })

    sendAXCounterV2("EditProfileImageR15UpgradePromptInteraction", { action = tostring(str1) })
end

return module
