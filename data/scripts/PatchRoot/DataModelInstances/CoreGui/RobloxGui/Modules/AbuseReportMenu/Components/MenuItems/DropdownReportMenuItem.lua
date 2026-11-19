-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local CorePackages = game:GetService("CorePackages")
local UIBlox = require(CorePackages.Packages.UIBlox)
local React = require(CorePackages.Packages.React)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local DropdownMenu = UIBlox.App.Menu.DropdownMenu
local ReportMenuItem = require(AbuseReportMenu.Components.MenuItems.ReportMenuItem)
local useStyle = UIBlox.Core.Style.useStyle
local getMenuItemSizings = require(AbuseReportMenu.Utility.getMenuItemSizings)

local FFlagHideShortcutsOnReportDropdown = require(AbuseReportMenu.Flags.FFlagHideShortcutsOnReportDropdown)

local Cryo = require(CorePackages.Packages.Cryo)

local function DropdownReportMenuItem(arg1)
    local theme = useStyle().Theme
    local menuItemSizings = getMenuItemSizings()
    local element

    if arg1.readonlyValue ~= nil then
        element = React.createElement("TextLabel", {
            Text = arg1.readonlyValue,
            Font = AppFonts.default:getMedium(),
            TextColor3 = theme.TextEmphasis.Color,
            TextTransparency = theme.TextMuted.Transparency,
            TextSize = menuItemSizings.DropdownTextSize,
            TextWrapped = true,
            TextXAlignment = if arg1.isSmallPortraitViewport then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, arg1.minHeight),
            BackgroundTransparency = 1
        })
    else
        local createElement = React.createElement
        local var1 = DropdownMenu

        local tbl1 = {
            placeholder = arg1.placeholderText,
            onChange = arg1.onSelect,
            height = UDim.new(0, 48),
            screenSize = Vector2.new(2400, 1800),
            errorState = false,
            showDropShadow = true,
            fixedListHeight = 180,
            cellDatas = Cryo.List.map(arg1.selections, function(text)
                return { text = text }
            end),
            onMenuOpenChange = if FFlagHideShortcutsOnReportDropdown then arg1.onMenuOpenChange else nil
        }

        element = createElement(var1, tbl1)
    end

    return React.createElement(ReportMenuItem, {
        label = arg1.label,
        layoutOrder = arg1.layoutOrder,
        rightComponent = element,
        menuContainerWidth = arg1.menuContainerWidth,
        isSmallPortraitViewport = arg1.isSmallPortraitViewport
    })
end

return DropdownReportMenuItem
