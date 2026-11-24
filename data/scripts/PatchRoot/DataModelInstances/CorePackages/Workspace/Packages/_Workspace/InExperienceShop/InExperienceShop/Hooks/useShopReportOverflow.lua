-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)

local _AbuseVector = require(InExperienceShopParent.GenericAbuseReporting.AbuseVector)

local shopOverflowConstants = require(InExperienceShop.Components.Shared.shopOverflowConstants)

return {
    useShopReportOverflow = function(tbl1)
        local isOverflowMenuOpen, var2 = React.useState(false)

        local reportSession, var4 = React.useState(nil)

        local onOverflowActivated = React.useCallback(function()
            var2(function(arg1): boolean
                return not arg1
            end)
        end, {})

        local onOverflowMenuClosed = React.useCallback(function()
            var2(false)
        end, {})

        local onMenuItemActivated = React.useCallback(function(arg1)
            var2(false)

            if tostring(arg1) == shopOverflowConstants.REPORT_MENU_ITEM_ID and tbl1.isReportingEnabled then
                var4(tbl1.buildReportSession())
            end
        end, { tbl1.isReportingEnabled, tbl1.buildReportSession })

        local onReportClose = React.useCallback(function()
            var4(nil)
        end, {})

        return {
            isOverflowMenuOpen = isOverflowMenuOpen,
            reportSession = reportSession,
            isReportingEnabled = tbl1.isReportingEnabled,
            onOverflowActivated = onOverflowActivated,
            onOverflowMenuClosed = onOverflowMenuClosed,
            onMenuItemActivated = onMenuItemActivated,
            onReportClose = onReportClose
        }
    end
}
