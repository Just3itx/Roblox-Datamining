-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local ReportTextEntry = require(AbuseReportMenu.Components.ReportTextEntry)
local ReportMenuItem = require(AbuseReportMenu.Components.MenuItems.ReportMenuItem)
local Constants = require(AbuseReportMenu.Components.Constants)

local function FreeCommentsMenuItem(tbl1)
    return React.createElement(ReportMenuItem, {
        label = "Abuse Description",
        isRightComponentFullWidth = true,
        layoutOrder = tbl1.layoutOrder,
        rightComponent = React.createElement(ReportTextEntry, {
            layoutOrder = tbl1.layoutOrder,
            text = tbl1.comment,
            placeholderText = tbl1.placeholderText,
            onUpdate = tbl1.onUpdate
        }),
        heightOverride = Constants.FreeCommentsMenuItemHeight,
        menuContainerWidth = tbl1.menuContainerWidth,
        isSmallPortraitViewport = tbl1.isSmallPortraitViewport
    })
end

return FreeCommentsMenuItem
