-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local AbuseCategory = require(GenericAbuseReporting.Enums.AbuseCategory)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local ValueToAbuseCategory = require(GenericAbuseReporting.Enums.ValueToAbuseCategory)

local FFlagLuaAppEnableReportBadge = SharedFlags.FFlagLuaAppEnableReportBadge
local FFlagEnableReportingFlowForDevSubs = SharedFlags.FFlagEnableReportingFlowForDevSubs
local FFlagEnableReportingFlowForExperienceShop = SharedFlags.FFlagEnableReportingFlowForExperienceShop
local FFlagGenericAbuseReportingUnifyReportTags = require(GenericAbuseReporting.Flags.FFlagGenericAbuseReportingUnifyReportTags)

local function func1(tbl1)
    local tbl2 = {
        ENTRY_POINT = "in-app",
        SUBMITTER_USER_ID = tbl1.localPlayerUserId
    }

    if FFlagGenericAbuseReportingUnifyReportTags then
        tbl2.REPORTED_ABUSE_CATEGORY = ValueToAbuseCategory[tbl1.formData.legacy_abuse_category]
            or tbl1.formData.abuse_category
            or AbuseCategory.ABUSE_CATEGORY_INVALID
    else
        tbl2.REPORTED_ABUSE_CATEGORY = tbl1.formData.abuse_category or AbuseCategory.ABUSE_CATEGORY_INVALID
    end
    tbl2.REPORTER_COMMENT = tbl1.formData.free_comment or ""

    return tbl2
end

local function func2(tbl1)
    local var1 = Dash.copy(tbl1.tags)

    local targetId = tbl1.targetId
    if tbl1.abuseVector == AbuseVector.Looks or tbl1.abuseVector == AbuseVector.CommunityLooks then
        local targetId2 = tbl1.targetId
        var1.REPORT_TARGET_LOOK_ID = targetId2.lookId
        var1.REPORT_TARGET_LOOK_INCLUDED_ASSET_IDS = targetId2.lookAssetsIds
    elseif tbl1.abuseVector == AbuseVector.UgcBundle then
        var1.UGC_BUNDLE_ID = targetId
    elseif tbl1.abuseVector == AbuseVector.ContentPostScreenshot then
        var1.CONTENT_POST_ID = targetId
    elseif tbl1.abuseVector == AbuseVector.UserProfile then
        var1.REPORT_TARGET_USER_ID = targetId
    elseif tbl1.abuseVector == AbuseVector.Accessory or tbl1.abuseVector == AbuseVector.Place then
        var1.REPORT_TARGET_ASSET_ID = targetId
    elseif FFlagEnableReportingFlowForDevSubs and tbl1.abuseVector == AbuseVector.Subscription then
        local targetId2 = tbl1.targetId
        var1.REPORT_TARGET_SUBSCRIPTION_TARGET_KEY = targetId2.subscriptionTargetKey
        var1.REPORT_TARGET_ASSET_ID = targetId2.imageAssetId
    elseif FFlagEnableReportingFlowForExperienceShop and tbl1.abuseVector == AbuseVector.DeveloperProduct then
        var1.REPORT_TARGET_DEVELOPER_PRODUCT_ID = targetId
    elseif FFlagEnableReportingFlowForExperienceShop and tbl1.abuseVector == AbuseVector.GamePass then
        var1.REPORT_TARGET_GAME_PASS_ID = targetId
    elseif FFlagEnableReportingFlowForExperienceShop and tbl1.abuseVector == AbuseVector.InExperienceShop then
        var1.PLACE_ID = targetId
    elseif tbl1.abuseVector == AbuseVector.Group then
        var1.REPORT_TARGET_GROUP_ID = targetId
    elseif tbl1.abuseVector == AbuseVector.Notifications then
        var1.NOTIFICATION_ID = targetId
    elseif tbl1.abuseVector == AbuseVector.AdV2 then
        var1.AD_ID = targetId
    elseif FFlagLuaAppEnableReportBadge and tbl1.abuseVector == AbuseVector.Badge then
        var1.REPORT_TARGET_BADGE_ID = targetId
    end

    if tbl1.abuseVector == AbuseVector.Accessory then
        var1.REPORTED_ABUSE_VECTOR = tbl1.custom and tbl1.custom.assetTypeName or AbuseVector.Accessory
        if var1.REPORTED_ABUSE_VECTOR == "EmoteAnimation" then
            var1.REPORTED_ABUSE_VECTOR = AbuseVector.Accessory
            return var1
        end
    else
        var1.REPORTED_ABUSE_VECTOR = tbl1.abuseVector
    end

    return var1
end

return function(tbl1)
    local tags = func1({ formData = tbl1.formData, localPlayerUserId = tbl1.localPlayerUserId })

    local var1 = func2({ abuseVector = tbl1.abuseVector, custom = tbl1.custom, targetId = tbl1.targetId, tags = tags })

    Dash.forEach(tbl1.additionalReportTags or {}, function(arg1)
        if not arg1.tagKey or arg1.tagKey == "" or not arg1.tagValue or arg1.tagValue == "" then
            return
        end

        if var1[arg1.tagKey] ~= nil then
            local var2 = var1[arg1.tagKey]
            var1[arg1.tagKey] = var2 .. "," .. arg1.tagValue
        else
            var1[arg1.tagKey] = arg1.tagValue
        end
    end)

    return var1
end
