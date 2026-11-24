-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent
local React = require(InExperienceSideSheetParent.React)
local Foundation = require(InExperienceSideSheetParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text

local AnalyticsConstants = require(InExperienceSideSheet.Analytics.AnalyticsConstants)
local SidesheetAnalytics = require(InExperienceSideSheet.Analytics.SidesheetAnalytics)

local closePeoplePageOpenedWithSideSheet = require(InExperienceSideSheet.Utils.closePeoplePageOpenedWithSideSheet)
local toggleSideSheet = require(InExperienceSideSheet.Utils.toggleSideSheet)

local Flags = require(InExperienceSideSheet.Flags)
local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)
local FFlagSideSheetOpenPeoplePage = Flags.FFlagSideSheetOpenPeoplePage
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav

return React.memo(function(tbl1) -- name: VerticalItem
    local onActivated = React.useCallback(function()
        tbl1.onActivated()
        if FFlagSideSheetOpenPeoplePage then
            closePeoplePageOpenedWithSideSheet()
        end
        toggleSideSheet(false)
        SidesheetAnalytics.logSidesheetClosed(AnalyticsConstants.Source.ItemSelected)
    end, { tbl1.onActivated })

    local var2 = if FFlagSideSheetFocusNav then React.useRef(nil) else nil

    local var3 = if FFlagSideSheetFocusNav then React.useCallback(function(current)
        if var2 then
            var2.current = current
        end
        if current and tbl1.firstIntegrationToFocusCallback then
            tbl1.firstIntegrationToFocusCallback(current)
        end
    end, { tbl1.firstIntegrationToFocusCallback }) else nil

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "row align-y-center gap-none size-full-1000 padding-left-xsmall radius-medium",
        LayoutOrder = tbl1.layoutOrder,
        onActivated = onActivated,
        selection = if FFlagSideSheetFocusNav and tbl1.disableGamepadDirections then {
            NextSelectionRight = if tbl1.disableGamepadDirections.right then var2 else nil,
            NextSelectionLeft = if tbl1.disableGamepadDirections.left then var2 else nil
        } else nil,
        ref = 0
    }

    if not FFlagSideSheetFocusNav then
        var3 = nil
    end

    tbl2.ref = var3
    return createElement(var4, tbl2, {
        IconContainer = React.createElement(
            View,
            { tag = "align-x-center align-y-center size-1000", LayoutOrder = 1 },
            {
                Icon = tbl1.icon({ visible = true })
            }
        ),
        Label = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl1.label,
            tag = "auto-xy padding-x-small text-label-medium text-align-x-left text-truncate-split content-emphasis"
        })
    })
end)
