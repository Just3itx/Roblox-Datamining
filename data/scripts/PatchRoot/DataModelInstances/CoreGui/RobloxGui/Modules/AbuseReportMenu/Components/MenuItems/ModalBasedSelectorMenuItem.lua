-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local ModalBasedSelector = require(AbuseReportMenu.Components.ModalBasedSelector)
local ReportMenuItem = require(AbuseReportMenu.Components.MenuItems.ReportMenuItem)

return function(arg1)
    return React.createElement(ReportMenuItem, {
        label = arg1.label,
        layoutOrder = arg1.layoutOrder,
        rightComponent = React.createElement(ModalBasedSelector, arg1),
        menuContainerWidth = arg1.menuContainerWidth,
        isSmallPortraitViewport = arg1.isSmallPortraitViewport,
        placeholderText = arg1.placeholderText
    })
end
