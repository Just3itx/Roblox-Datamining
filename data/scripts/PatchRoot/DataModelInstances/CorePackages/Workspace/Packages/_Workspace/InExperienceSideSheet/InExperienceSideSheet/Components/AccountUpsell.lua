-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local _Chrome = require(InExperienceSideSheetParent.Chrome)
local Foundation = require(InExperienceSideSheetParent.Foundation)
local Localization = require(InExperienceSideSheetParent.Localization)
local React = require(InExperienceSideSheetParent.React)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization

local AnalyticsConstants = require(InExperienceSideSheet.Analytics.AnalyticsConstants)
local SidesheetAnalytics = require(InExperienceSideSheet.Analytics.SidesheetAnalytics)
local closePeoplePageOpenedWithSideSheet = require(InExperienceSideSheet.Utils.closePeoplePageOpenedWithSideSheet)
local toggleSideSheet = require(InExperienceSideSheet.Utils.toggleSideSheet)

local FFlagSideSheetOpenPeoplePage = require(InExperienceSideSheet.Flags).FFlagSideSheetOpenPeoplePage

return React.memo(function(arg1) -- name: AccountUpsell
    local var1 = useTokens()
    local var2 = useLocalization(
        {
            title = "CoreScripts.InGameMenu.UnlockMore.Title",
            description = "CoreScripts.InGameMenu.UnlockMore.Description"
        }
    )

    local onActivated = React.useCallback(function()
        arg1.onActivated()
        if FFlagSideSheetOpenPeoplePage then
            closePeoplePageOpenedWithSideSheet()
        end
        toggleSideSheet(false)
        SidesheetAnalytics.logSidesheetClosed(AnalyticsConstants.Source.AccountUpsell)
    end, { arg1.onActivated })

    return React.createElement(View, {
        LayoutOrder = arg1.layoutOrder,
        tag = "size-full-0 auto-y padding-bottom-medium padding-top-small",
        testId = "account-upsell-container"
    }, {
        Card = React.createElement(View, {
            onActivated = onActivated,
            tag = "row align-y-center size-full-0 auto-y padding-medium radius-medium bg-shift-200",
            testId = "account-upsell-card"
        }, {
            LeadingAccessory = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    tag = "row align-x-center align-y-center size-1200-1200 radius-medium clip bg-system-emphasis"
                },
                {
                    Logo = React.createElement(Icon, {
                        name = IconName.Tilt,
                        size = var1.Size.Size_1000,
                        style = var1.DarkMode.Content.Emphasis,
                        testId = "account-upsell-logo",
                        variant = IconVariant.Filled
                    })
                }
            ),
            Content = React.createElement(View, {
                LayoutOrder = 2,
                tag = "col fill auto-y padding-left-medium"
            }, {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = var2.title,
                    tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-emphasis"
                }),
                Description = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = var2.description,
                    tag = "size-full-0 auto-y text-body-small text-align-x-left text-truncate-end content-emphasis"
                })
            })
        })
    })
end)
