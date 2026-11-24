-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

local bool1 = game:DefineFastFlag("UpdateAbuseReportRevampItemAbuseVector", false)
local FFlagLuaAppEnableReportBadge = require(GenericAbuseReportingParent.SharedFlags).FFlagLuaAppEnableReportBadge
local FFlagEnableReportingFlowForDevSubs = require(GenericAbuseReportingParent.SharedFlags).FFlagEnableReportingFlowForDevSubs

local FFlagEnableReportingFlowForExperienceShop = require(GenericAbuseReportingParent.SharedFlags).FFlagEnableReportingFlowForExperienceShop

return function(tbl1)
    local result = {}

    if tbl1.abuseVector == AbuseVector.Looks then
        local targetId = tbl1.targetId
        result.REPORT_TARGET_LOOK_ID = targetId.lookId
        result.REPORT_TARGET_LOOK_INCLUDED_ASSET_IDS = targetId.lookAssetsIds
    elseif tbl1.abuseVector == AbuseVector.UgcBundle then
        result.UGC_BUNDLE_ID = tbl1.targetId
    elseif tbl1.abuseVector == AbuseVector.ContentPostScreenshot then
        result.CONTENT_POST_ID = tbl1.targetId
    elseif tbl1.abuseVector == AbuseVector.UserProfile then
        result.REPORT_TARGET_USER_ID = tbl1.targetId
    elseif tbl1.abuseVector == AbuseVector.Accessory or tbl1.abuseVector == AbuseVector.Place then
        result.REPORT_TARGET_ASSET_ID = tbl1.targetId
    elseif FFlagEnableReportingFlowForDevSubs and tbl1.abuseVector == AbuseVector.Subscription then
        local targetId = tbl1.targetId
        result.REPORT_TARGET_SUBSCRIPTION_TARGET_KEY = targetId.subscriptionTargetKey
        result.REPORT_TARGET_ASSET_ID = targetId.imageAssetId
    elseif FFlagEnableReportingFlowForExperienceShop and tbl1.abuseVector == AbuseVector.DeveloperProduct then
        result.REPORT_TARGET_DEVELOPER_PRODUCT_ID = tbl1.targetId
    elseif FFlagEnableReportingFlowForExperienceShop and tbl1.abuseVector == AbuseVector.GamePass then
        result.REPORT_TARGET_GAME_PASS_ID = tbl1.targetId
    elseif FFlagEnableReportingFlowForExperienceShop and tbl1.abuseVector == AbuseVector.InExperienceShop then
        result.PLACE_ID = tbl1.targetId
    elseif tbl1.abuseVector == AbuseVector.Group then
        result.REPORT_TARGET_GROUP_ID = tbl1.targetId
    elseif tbl1.abuseVector == AbuseVector.Notifications then
        result.NOTIFICATION_ID = tbl1.targetId
    elseif FFlagLuaAppEnableReportBadge and tbl1.abuseVector == AbuseVector.Badge then
        result.REPORT_TARGET_BADGE_ID = tbl1.targetId
    end

    result.ENTRY_POINT = "in-app"
    result.SUBMITTER_USER_ID = tbl1.submitterId
    result.REPORTED_ABUSE_CATEGORY = tbl1.abuseCategory
    result.REPORTER_COMMENT = tbl1.comment or ""

    if bool1 and tbl1.abuseVector == AbuseVector.Accessory then
        result.REPORTED_ABUSE_VECTOR = tbl1.custom and tbl1.custom.assetTypeName or AbuseVector.Accessory
        if result.REPORTED_ABUSE_VECTOR == "EmoteAnimation" then
            result.REPORTED_ABUSE_VECTOR = AbuseVector.Accessory
            return result
        end
    else
        result.REPORTED_ABUSE_VECTOR = tbl1.abuseVector
    end

    return result
end
