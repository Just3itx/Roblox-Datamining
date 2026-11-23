-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local AdGuiInteractivity = script:FindFirstAncestor("AdGuiInteractivity")
local AdGuiInteractivityParent = AdGuiInteractivity.Parent
local React = require(AdGuiInteractivityParent.React)
local UIBlox = require(AdGuiInteractivityParent.UIBlox)
local LinkingProtocol = require(AdGuiInteractivityParent.LinkingProtocol)
local Foundation = require(AdGuiInteractivityParent.Foundation)
local ColorMode = Foundation.Enums.ColorMode
local Localization = require(AdGuiInteractivityParent.Localization)
local UniversalAppPolicy = require(AdGuiInteractivityParent.UniversalAppPolicy)
local Http = require(AdGuiInteractivityParent.Http)
local RoactServices = require(AdGuiInteractivityParent.RoactServices)
local RoactServiceTags = require(AdGuiInteractivityParent.RoactServiceTags)
local RobloxAppHooks = require(AdGuiInteractivityParent.RobloxAppHooks)
local Screenshot = require(AdGuiInteractivityParent.Screenshot)
local LoggingProtocol = require(AdGuiInteractivityParent.LoggingProtocol)
local UrlBuilder = require(AdGuiInteractivityParent.UrlBuilder).UrlBuilder

local AdsInteractivityTelemetry = require(AdGuiInteractivity.AdsInteractivityTelemetry)

local useRoactService = RobloxAppHooks.useRoactService
local useAppPolicy = UniversalAppPolicy.useAppPolicy
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Constants = UIBlox.App.Style.Constants
local DefaultTwoStepReportFlow = require(AdGuiInteractivityParent.GenericAbuseReporting.DefaultTwoStepReportFlow)
local Button = Foundation.Button
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local useLocalization = Localization.Hooks.useLocalization
local default = LinkingProtocol.LinkingProtocol.default
local default2 = LoggingProtocol.default
local Url = Http.Url

local reportCategories = {{
    localizationKey = "CoreScripts.Ads.Label.InappropriateAd",
    value = "ABUSE_CATEGORY_INAPPROPRIATE_AD"
}}

local urlBuilder = UrlBuilder.new({ base = Url.BASE_URL, path = "illegal-content-reporting" })

local urlBuilder2 = UrlBuilder.new({ base = Url.CREATOR_HUB_URL, path = "store/asset/{assetId}" })

local urlBuilder3 = UrlBuilder.new({ base = Url.APIS_URL, path = "abuse-reporting/v1/abuse-report" })

local tbl2 = {
    eventName = "ReportImmersiveBrandedAdTotalCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 26, 3, 11 },
    description = "This event is fired when the user initiates submitting an immersive branded ad abuse report (before success or failure is known)."
}

local tbl3 = {
    eventName = "ReportImmersiveBrandedAdSuccessCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 26, 3, 11 },
    description = "This event is fired when an immersive branded ad abuse report is successfully submitted to the server."
}

local tbl4 = {
    eventName = "ReportImmersiveBrandedAdFailureCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 26, 3, 11 },
    description = "This event is fired when submitting an immersive branded ad abuse report fails."
}

local tbl5 = {
    eventName = "ReportImmersiveBrandedAdHttpFaulreEvent",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:DefineFastInt("ReportImmersiveBrandedAdHttpFaulreEventThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 11, 3 },
    description = "This event is fired when the HTTP request to submit an immersive branded ad abuse report fails."
}

local function logReportImmersiveBrandedAdTotalCounter() -- Luacid: Inlined by compiler; 1 call site recovered
    default2:logRobloxTelemetryCounter(tbl2)
end

local function logReportImmersiveBrandedAdSuccessCounter() -- Luacid: Inlined by compiler; 1 call site recovered
    default2:logRobloxTelemetryCounter(tbl3)
end

local function logReportImmersiveBrandedAdFailureCounter(reason: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    default2:logRobloxTelemetryCounter(tbl4, 1, { reason = reason })
end

local function logReportImmersiveBrandedAdHttpFailureEvent(arg1)
    local tbl6 = {}
    if type(arg1) == "string" then
        tbl6.error = arg1:sub(1, 500)
    elseif type(arg1) == "table" then
        if arg1.Body and type(arg1.Body) == "string" then
            tbl6.body = arg1.Body:sub(1, 500)
        end
        if arg1.StatusCode and type(arg1.StatusCode) == "number" then
            tbl6.statusCode = tostring(arg1.StatusCode)
        end
    end

    default2:logRobloxTelemetryEvent(tbl5, nil, tbl6)
end

local function sendImmersiveBrandedAdAbuseReport(arg1, tbl6): boolean
    local input = {
        abuseVector = "ad_v2",
        targetType = "ad_v2",
        category = tbl6.reason,
        comment = tbl6.comment,
        custom = {
            SCREENSHOT_ID = tbl6.screenshotId,
            PLACE_ID = tbl6.placeId
        },
        submitterId = tbl6.userId,
        targetIdStr = `immersiveBrandedAd/{tbl6.immersiveBrandedAdId}`
    }

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success then
        logReportImmersiveBrandedAdFailureCounter("jsonEncode")
        return false
    end

    task.spawn(function()
        local var1 = urlBuilder3()
        arg1(var1, "POST", { postBody = result }):andThen(function(_)
            logReportImmersiveBrandedAdSuccessCounter()
        end, function(arg2)
            logReportImmersiveBrandedAdFailureCounter("http")
            logReportImmersiveBrandedAdHttpFailureEvent(arg2)
        end)
    end)

    return true
end

local function ImmersiveBrandedAdReportAdDialog(tbl6)
    local immersiveBrandedAdId = tbl6.immersiveBrandedAdId
    local var1 = useRoactService(RoactServiceTags.RoactNetworking)
    local var2 = React.useRef(nil)
    local var3, var4 = React.useState(false)

    local var5 = useLocalization({ LinkText = "CoreScripts.Ads.Label.IllegalContentReportingLink" })

    local var6 = useAppPolicy(function(arg1)
        return arg1.getShowIllegalContentReportingUI()
    end)

    local onActivated = React.useCallback(function()
        local contentUrl = urlBuilder2({ assetId = immersiveBrandedAdId })
        local var8 = UrlBuilder.addQueryString(urlBuilder(), { contentURL = contentUrl })

        default:openURL(var8):catch(function(_)
            AdsInteractivityTelemetry.logImmersiveBrandedAdLinkingFailedCounter("reportAd.eudsaIllegalContent")
            tbl6.onDismiss()
        end)
    end, { immersiveBrandedAdId, tbl6.onDismiss })

    local var8 = React.useCallback(function()
        return React.createElement(View, {
            tag = "col margin-x-medium padding-top-medium size-full-0 auto-y"
        }, {
            linkButton = React.createElement(Button, {
                text = var5.LinkText,
                variant = ButtonVariant.Link,
                onActivated = onActivated,
                icon = "icons/navigation/externallink",
                size = InputSize.Small
            })
        })
    end, { onActivated, var5.LinkText })

    local onSubmit = React.useCallback(function(reason, comment)
        if RunService:IsStudio() or _G.__TESTEZ_RUNNING_TEST__ or _G.__TEST_SUITE_PACKAGE__ then
            return true
        end

        logReportImmersiveBrandedAdTotalCounter()
        local localPlayer = game.Players.LocalPlayer
        if not localPlayer then
            logReportImmersiveBrandedAdFailureCounter("noPlayer")
            return false
        end

        if not var2.current then
            logReportImmersiveBrandedAdFailureCounter("noScreenshot")
            return false
        end

        return (sendImmersiveBrandedAdAbuseReport(var1, {
            reason = reason,
            comment = comment,
            immersiveBrandedAdId = immersiveBrandedAdId,
            screenshotId = var2.current,
            userId = localPlayer.UserId,
            placeId = game.PlaceId
        }))
    end, { immersiveBrandedAdId, var1 })

    React.useEffect(function()
        if not (RunService:IsStudio() or _G.__TESTEZ_RUNNING_TEST__ or _G.__TEST_SUITE_PACKAGE__) then
            Screenshot.ScreenshotManager:TakeScreenshotWithCallback(function(current)
                var2.current = current
            end, nil)
        end

        task.defer(function()
            var4(true)
        end)
    end, {})

    if not var3 then
        return nil
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local tbl7 = {}
    local tbl8 = {
        modal = React.createElement("TextButton", { Text = "", BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Modal = true }),
        abuseReportFlow = 0
    }

    local createElement2 = React.createElement
    local var10 = DefaultTwoStepReportFlow
    local tbl9 = {
        analyticsContext = "Ad",
        onCloseProps = {
            hasPreviousSteps = false,
            onAbandon = tbl6.onDismiss
        },
        onSubmitProps = { hasNextSteps = false, onSubmit = onSubmit },
        onComplete = tbl6.onDismiss,
        reportCategories = reportCategories,
        reportCategoryDefaultKey = reportCategories[1].value,
        isReportCategoryReadonly = true,
        localizationKeys = {
            formTitle = "CoreScripts.Ads.Label.ReportAd",
            completeTitle = "Feature.ReportAbuse.Title.SelectInSceneThankYou",
            completeDescription = "Feature.ReportAbuse.Label.SelectInSceneComplete"
        },
        footerContent = 0
    }

    if not var6 then
        var8 = nil
    end

    tbl9.footerContent = var8
    tbl8.abuseReportFlow = createElement2(var10, tbl9)
    return createElement(fragment, tbl7, tbl8)
end

return function(tbl6)
    return React.createElement(
        RoactServices.RoactServices.ServiceProvider,
        {
            services = {
                [RoactServiceTags.RoactNetworking] = Http.NetworkLayers.requestInternalWrapper(HttpService)
            }
        },
        {
            policyProvider = React.createElement(
                UniversalAppPolicy.RoactAppPolicy.Provider,
                {
                    policy = { UniversalAppPolicy.AppFeaturePolicies }
                },
                {
                    appStyleProvider = React.createElement(
                        AppStyleProvider,
                        {
                            style = {
                                themeName = ColorMode.Dark,
                                fontName = Constants.FontName.Gotham
                            }
                        },
                        {
                            resizeFrame = React.createElement(
                                "Frame",
                                {
                                    Position = UDim2.fromScale(0.5, 0.5),
                                    AnchorPoint = Vector2.new(0.5, 0.5),
                                    Size = UDim2.fromScale(1, 0.6),
                                    AutomaticSize = Enum.AutomaticSize.Y,
                                    BackgroundTransparency = 1
                                },
                                {
                                    reportAdDialog = React.createElement(ImmersiveBrandedAdReportAdDialog, tbl6)
                                }
                            )
                        }
                    )
                }
            )
        }
    )
end
