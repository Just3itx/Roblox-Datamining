-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local AssetFavorites = require(Songbird.Parent.AssetFavorites)
local Foundation = require(Songbird.Parent.Foundation)
local React = require(Songbird.Parent.React)
local FocusNavigationUtils = require(Songbird.Parent.FocusNavigationUtils)

local logger = require(Songbird.logger)
local _types = require(Songbird.types)

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local DefaultTwoStepReportFlow = require(Songbird.Parent.GenericAbuseReporting.DefaultTwoStepReportFlow)
local AbuseCategory = require(Songbird.Parent.GenericAbuseReporting.AbuseCategory)
local AbuseEntrypoint = require(Songbird.Parent.GenericAbuseReporting.AbuseEntrypoint)

local useCallback = React.useCallback
local useLocalUserId = AssetFavorites.useLocalUserId

local reportCategories = {
    {
        localizationKey = "Feature.SongDetails.Label.InappropriateAudio",
        value = "InappropriateAudio"
    },
    {
        localizationKey = "Feature.SongDetails.Label.InappropriateThumbnail",
        value = "InappropriateThumbnail"
    }
}

local function buildReport(tbl2)
    local input = { tags = 0 }
    local tags = {
        ENTRY_POINT = {
            valueList = {{
                data = AbuseEntrypoint.APP
            }}
        },
        SUBMITTER_USER_ID = 0,
        REPORTED_ABUSE_CATEGORY = 0,
        REPORTER_COMMENT = 0,
        REPORT_TARGET_ASSET_ID = 0,
        REPORTED_ABUSE_VECTOR = 0,
        VARIANT = 0
    }

    local submitterUserId = {
        valueList = {{
            data = tostring(tbl2.userId)
        }}
    }
    tags.SUBMITTER_USER_ID = submitterUserId

    tags.REPORTED_ABUSE_CATEGORY = {
        valueList = {{
            data = AbuseCategory.ABUSE_CATEGORY_INAPT_CONTENT
        }}
    }

    tags.REPORTER_COMMENT = {
        valueList = {{
            data = tbl2.comment
        }}
    }

    tags.REPORT_TARGET_ASSET_ID = {
        valueList = {{
            data = tbl2.assetId
        }}
    }

    tags.REPORTED_ABUSE_VECTOR = {
        valueList = {{
            data = tbl2.abuseVector
        }}
    }

    tags.VARIANT = {
        valueList = {{
            data = tbl2.variant
        }}
    }
    input.tags = tags

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)

    return if success then result else nil
end

return React.memo(function(tbl2) -- name: ReportSongDialog
    local userId = useLocalUserId()

    local var2 = useCallback(function()
        if tbl2.onClose then
            tbl2.onClose()
        end
    end, { tbl2.onClose })

    local onSubmit = useCallback(function(str1: string, comment: string): boolean
        local bool1 = str1 == reportCategories[1].value
        local assetId = if bool1 then tbl2.audio.assetId else tbl2.audio.thumbnailAssetId

        if assetId then
            local report = buildReport({
                userId = userId,
                comment = comment,
                assetId = assetId,
                abuseVector = if bool1 then "audio" else "image",
                variant = tbl2.analyticsSource
            })

            if report then
                local localPlayer = Players.LocalPlayer
                if localPlayer then
                    local success, result = pcall(function()
                        Players:ReportAbuseV3(localPlayer, report)
                    end)

                    if success then
                        logger:info(`Abuse report sent for asset [{assetId}] with reason [{str1}] and comment [{comment}]`)
                    else
                        logger:warning(`Failed to submit abuse report for asset {assetId}: {result}`)
                    end
                end
            end
        end

        return true
    end, {
        tbl2.analyticsSource,
        tbl2.audio.assetId,
        tbl2.audio.thumbnailAssetId,
        userId
    })
    return React.createElement(Foundation.View, {
        tag = "size-full-0 auto-y",
        selectionGroup = true
    }, {
        FocusRoot = React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            {
                AbuseReportFlow = React.createElement(DefaultTwoStepReportFlow, {
                    analyticsContext = tbl2.analyticsSource,
                    onCloseProps = { hasPreviousSteps = false, onAbandon = var2 },
                    onSubmitProps = { hasNextSteps = false, onSubmit = onSubmit },
                    onComplete = var2,
                    reportCategories = reportCategories,
                    reportCategoryDefaultKey = reportCategories[1].value,
                    localizationKeys = { formTitle = "Feature.SongDetails.Action.ReportAudio" }
                })
            }
        )
    })
end)
