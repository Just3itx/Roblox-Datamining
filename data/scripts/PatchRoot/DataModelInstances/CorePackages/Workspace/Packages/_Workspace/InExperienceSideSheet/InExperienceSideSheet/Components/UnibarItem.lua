-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Foundation = require(InExperienceSideSheetParent.Foundation)
local React = require(InExperienceSideSheetParent.React)

local View = Foundation.View

local IconHost = require(script.Parent.IconHost)

local AnalyticsConstants = require(InExperienceSideSheet.Analytics.AnalyticsConstants)
local SidesheetAnalytics = require(InExperienceSideSheet.Analytics.SidesheetAnalytics)

local closePeoplePageOpenedWithSideSheet = require(InExperienceSideSheet.Utils.closePeoplePageOpenedWithSideSheet)
local toggleSideSheet = require(InExperienceSideSheet.Utils.toggleSideSheet)

local Flags = require(InExperienceSideSheet.Flags)
local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)
local FFlagSideSheetOpenPeoplePage = Flags.FFlagSideSheetOpenPeoplePage
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav

return React.memo(function(tbl1) -- name: UnibarItem
    local onActivated = React.useCallback(function()
        tbl1.onActivated()
        if FFlagSideSheetOpenPeoplePage then
            closePeoplePageOpenedWithSideSheet()
        end
        toggleSideSheet(false)
        SidesheetAnalytics.logSidesheetClosed(AnalyticsConstants.Source.ItemSelected)
    end, { tbl1.onActivated })

    local ref = if FFlagSideSheetFocusNav then React.useRef(nil) else nil
    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "auto-xy",
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        IconHost = React.createElement(IconHost, { icon = tbl1.icon, notification = tbl1.notification }),
        ActivationOverlay = 0
    }
    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = {
        tag = "size-full radius-circle",
        ZIndex = 10,
        onActivated = onActivated,
        selection = if FFlagSideSheetFocusNav and tbl1.disableGamepadDirections then {
            NextSelectionLeft = if tbl1.disableGamepadDirections.left then ref else nil
        } else nil,
        ref = ref
    }
    tbl3.ActivationOverlay = createElement2(var4, tbl4)
    return createElement(var3, tbl2, tbl3)
end)
