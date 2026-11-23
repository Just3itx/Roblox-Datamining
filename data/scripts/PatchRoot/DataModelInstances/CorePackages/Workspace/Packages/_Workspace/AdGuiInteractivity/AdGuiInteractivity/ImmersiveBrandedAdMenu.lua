-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local AdGuiInteractivity = script:FindFirstAncestor("AdGuiInteractivity")
local AdGuiInteractivityParent = AdGuiInteractivity.Parent
local React = require(AdGuiInteractivityParent.React)
local Foundation = require(AdGuiInteractivityParent.Foundation)
local Localization = require(AdGuiInteractivityParent.Localization)

local ImmersiveBrandedAdWhyThisAdDialog = require(AdGuiInteractivity.ImmersiveBrandedAdWhyThisAdDialog)
local ImmersiveBrandedAdReportAdDialog = require(AdGuiInteractivity.ImmersiveBrandedAdReportAdDialog)
local AdsInteractivityTelemetry = require(AdGuiInteractivity.AdsInteractivityTelemetry)

local Menu = Foundation.Menu
local InputSize = Foundation.Enums.InputSize
local PopoverSide = Foundation.Enums.PopoverSide
local useLocalization = Localization.Hooks.useLocalization
local useMeasurableRef = Foundation.Hooks.useMeasurableRef

return function(tbl1)
    local screenPosition = tbl1.screenPosition
    local var1 = useLocalization({ WhyThisAdText = "CoreScripts.Ads.Label.WhyThisAd", ReportAdText = "CoreScripts.Ads.Label.ReportAd" })

    local var2, var3 = React.useState(nil)
    local anchorRef = useMeasurableRef(screenPosition)

    React.useEffect(function()
        local connection = GuiService.MenuOpened:Connect(function()
            tbl1.onDismiss()
        end)

        return function()
            connection:Disconnect()
        end
    end, { tbl1.onDismiss })

    local items = React.useMemo(function()
        return {
            {
                id = "whyThisAd",
                icon = "icons/actions/info_small",
                text = var1.WhyThisAdText
            },
            {
                id = "reportAd",
                icon = "icons/actions/feedback",
                text = var1.ReportAdText
            }
        }
    end, { var1.WhyThisAdText, var1.ReportAdText })

    local onActivated = React.useCallback(function(str1: string)
        if str1 == "whyThisAd" then
            AdsInteractivityTelemetry.logImmersiveBrandedAdButtonClickCounter("whyThisAd")
            var3("whyThisAd")
        elseif str1 == "reportAd" then
            AdsInteractivityTelemetry.logImmersiveBrandedAdButtonClickCounter("reportAd")
            var3("reportAd")
        end
    end, {})

    if var2 == "whyThisAd" then
        return React.createElement(
            ImmersiveBrandedAdWhyThisAdDialog,
            {
                advertiserName = tbl1.advertiserName,
                onDismiss = tbl1.onDismiss
            }
        )
    elseif var2 == "reportAd" then
        return React.createElement(
            ImmersiveBrandedAdReportAdDialog,
            {
                immersiveBrandedAdId = tbl1.immersiveBrandedAdId,
                onDismiss = tbl1.onDismiss
            }
        )
    end
    return React.createElement(React.Fragment, nil, {
        menu = React.createElement(Menu, {
            isOpen = true,
            items = items,
            size = InputSize.Small,
            side = PopoverSide.Right,
            onActivated = onActivated,
            onPressedOutside = tbl1.onDismiss,
            anchorRef = anchorRef
        }),
        modal = React.createElement("TextButton", { Text = "", BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Modal = true })
    })
end
