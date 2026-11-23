-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local Roact = require(scriptParentParent.Roact)
local UIBlox = require(scriptParentParent.UIBlox)
local AdsDisplayOrder = require(scriptParent.AdsDisplayOrder)
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local LocalizationService = game:GetService("LocalizationService")
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider
local Localization = require(scriptParentParent.RobloxAppLocales).Localization
local DefaultTwoStepReportFlow = require(scriptParentParent.GenericAbuseReporting.DefaultTwoStepReportFlow)
local Players = game:GetService("Players")
local ScreenshotManager = require(scriptParentParent.Screenshot).ScreenshotManager
local HttpService = game:GetService("HttpService")
local getAppFeaturePolicies = require(scriptParentParent.UniversalAppPolicy).getAppFeaturePolicies
local LoggingProtocol = require(scriptParentParent.LoggingProtocol)
local default = LoggingProtocol.default

local ReportAdFooter = require(scriptParent.ReportAdFooter)

local Flags = require(script.Parent.Flags)
local enableHideReportAdModalDuringScreenshot = Flags.GetEnableHideReportAdModalDuringScreenshot()

local AdsInteractivityTelemetry = require(scriptParent.AdsInteractivityTelemetry)

local reportCategories = {{
    localizationKey = "CoreScripts.Ads.Label.InappropriateAd",
    value = "ABUSE_CATEGORY_INAPPROPRIATE_AD"
}}

function buildReport(userId: number, str1: string, str2: string, str3: string, str4: string): string
    local input = { tags = 0 }
    local tags = {
        ENTRY_POINT = {
            valueList = {{ data = "in-experience" }}
        },
        SUBMITTER_USER_ID = {
            valueList = {{
                data = tostring(userId)
            }}
        },
        REPORTED_ABUSE_CATEGORY = {
            valueList = {{ data = str2 }}
        },
        PLACE_ID = 0,
        REPORTER_COMMENT = 0,
        REPORTED_ABUSE_VECTOR = 0,
        SCREENSHOT_ID = 0,
        IDENTIFIED_ADS = 0
    }

    local placeId = {
        valueList = {{
            data = tostring(game.PlaceId)
        }}
    }
    tags.PLACE_ID = placeId

    tags.REPORTER_COMMENT = {
        valueList = {{ data = str3 }}
    }

    tags.REPORTED_ABUSE_VECTOR = {
        valueList = {{ data = "ad" }}
    }

    tags.SCREENSHOT_ID = {
        valueList = {{ data = str1 }}
    }

    tags.IDENTIFIED_ADS = {
        valueList = {{ data = str4 }}
    }
    input.tags = tags

    return HttpService:JSONEncode(input)
end

function ReportAdPopup(tbl2)
    local jsonTags = ""
    local input = { table.clone(tbl2.adInfo) }
    local str1 = HttpService:JSONEncode(input)

    local bool1 = true
    local appFeaturePolicies = getAppFeaturePolicies()
    if appFeaturePolicies ~= nil then
        local showIllegalContentReportingUi = appFeaturePolicies.getShowIllegalContentReportingUI()
        if showIllegalContentReportingUi == nil then
            showIllegalContentReportingUi = false
        end

        bool1 = showIllegalContentReportingUi
    else
        default:logRobloxTelemetryEvent({
            eventName = "UniversalAppPolicyCallFailed",
            backends = { LoggingProtocol.TelemetryBackends.Points },
            throttlingPercentage = Flags.GetFIntUniversalAppPolicyFailureTelemetryThrottleHundredthsPercent(),
            lastUpdated = { 24, 8, 22 },
            description = "Call to UniversalAppPolicy (GUAC) failed in Report Ad popup"
        }, nil, {
            assetId = input[1].assetId,
            encryptedAdTrackingData = input[1].encryptedAdTrackingData,
            encryptionMetadata = input[1].encryptionMetadata
        })
    end

    local onSubmit = React.useCallback(function(arg1, arg2): boolean
        if enableHideReportAdModalDuringScreenshot then
            tbl2.onClose()
        end
        ScreenshotManager:TakeScreenshotWithCallback(function(arg3)
            local localPlayer = Players.LocalPlayer
            if localPlayer ~= nil then
                jsonTags = buildReport(localPlayer.UserId, arg3, arg1, arg2, str1)
                Players:ReportAbuseV3(localPlayer, jsonTags)
                AdsInteractivityTelemetry.logReportAdEvent("submit")
            end
        end, nil)
        if enableHideReportAdModalDuringScreenshot and tbl2.onOpen then
            tbl2.onOpen()
        end

        return true
    end, {})

    local element = Roact.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 20) }),
            Roact.createElement(AppStyleProvider, {
                style = { themeName = "Dark", fontName = "Gotham" }
            }, {
                AbuseReportFlow = Roact.createElement(DefaultTwoStepReportFlow, {
                    analyticsContext = "Ad",
                    onCloseProps = {
                        hasPreviousSteps = false,
                        onAbandon = function()
                            AdsInteractivityTelemetry.logReportAdEvent("close")
                            tbl2.onClose()
                        end
                    },
                    onSubmitProps = { hasNextSteps = false, onSubmit = onSubmit },
                    onComplete = tbl2.onClose,
                    reportCategories = reportCategories,
                    reportCategoryDefaultKey = reportCategories[1].value,
                    isReportCategoryReadonly = true,
                    localizationKeys = {
                        formTitle = "CoreScripts.Ads.Label.ReportAd",
                        completeTitle = "Feature.ReportAbuse.Title.SelectInSceneThankYou",
                        completeDescription = "Feature.ReportAbuse.Label.SelectInSceneComplete"
                    },
                    scaleDialog = { X = 0.8, Y = 1 },
                    footerContent = function()
                        if bool1 then
                            return Roact.createElement(ReportAdFooter, { assetId = input[1].assetId })
                        end

                        return nil
                    end
                })
            })
        }
    )

    return Roact.createElement(
        "ScreenGui",
        {
            ResetOnSpawn = false,
            IgnoreGuiInset = true,
            DisplayOrder = AdsDisplayOrder.Modal,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            AutoLocalize = false,
            Enabled = tbl2.showReportAdPopup
        },
        Roact.createElement("Frame", {
            Position = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1
        }, { Roact.createElement("Frame", {
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.new(0.8, 0, 0.6, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            }, { element }) })
    )
end

return ReportAdPopup
