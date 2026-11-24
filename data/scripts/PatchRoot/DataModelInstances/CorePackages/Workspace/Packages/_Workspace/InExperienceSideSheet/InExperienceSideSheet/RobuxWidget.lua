-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local React = require(InExperienceSideSheetParent.React)

local _Chrome = require(InExperienceSideSheetParent.Chrome)
local View = require(InExperienceSideSheetParent.Foundation).View

local useLocalization = require(InExperienceSideSheetParent.Localization).Hooks.useLocalization

local RobuxPill = require(InExperienceSideSheetParent.RobuxPill).RobuxPill

local FFlagSideSheetFocusNav = require(InExperienceSideSheetParent.SharedFlags).FFlagSideSheetFocusNav

local AnalyticsConstants = require(InExperienceSideSheet.Analytics.AnalyticsConstants)
local SidesheetAnalytics = require(InExperienceSideSheet.Analytics.SidesheetAnalytics)
local useRobuxBalance = require(InExperienceSideSheet.Hooks.useRobuxBalance)
local toggleSideSheet = require(InExperienceSideSheet.Utils.toggleSideSheet)

return React.memo(function(arg1) -- name: RobuxWidget
    local robuxBalance = useRobuxBalance()

    local var2 = useLocalization({ buyRobux = "IAPExperience.RobuxUpsell.Action.BuyRobux" })

    local onBuyActivated = React.useCallback(function()
        arg1.onBuyActivated()
        toggleSideSheet(false)
        SidesheetAnalytics.logSidesheetClosed(AnalyticsConstants.Source.RobuxWidget)
    end, { arg1.onBuyActivated })

    local var4 = if FFlagSideSheetFocusNav then React.useCallback(function(arg2)
        if arg2 and arg1.firstIntegrationToFocusCallback then
            arg1.firstIntegrationToFocusCallback(arg2)
        end
    end, { arg1.firstIntegrationToFocusCallback }) else nil

    local createElement = React.createElement
    local var5 = View
    local tbl1 = {
        tag = "size-full-0 auto-y padding-bottom-medium",
        LayoutOrder = arg1.layoutOrder or 1
    }
    local tbl2 = { RobuxPill = 0 }
    local createElement2 = React.createElement
    local var6 = RobuxPill
    local tbl3 = {
        layoutOrder = 1,
        robuxBalance = robuxBalance,
        buyButtonText = var2.buyRobux,
        onBuyActivated = onBuyActivated,
        isCompact = true,
        ref = 0
    }
    if not FFlagSideSheetFocusNav then
        var4 = nil
    end

    tbl3.ref = var4
    tbl2.RobuxPill = createElement2(var6, tbl3)
    return createElement(var5, tbl1, tbl2)
end)
