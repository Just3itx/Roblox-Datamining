-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local CorePackages = game:GetService("CorePackages")
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local UIBlox = require(CorePackages.Packages.UIBlox)

local React = require(CorePackages.Packages.React)
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle
local Constants = require(AbuseReportMenu.Components.Constants)
local getMenuItemDimensions = require(AbuseReportMenu.Components.getMenuItemDimensions)
local getMenuItemSizings = require(AbuseReportMenu.Utility.getMenuItemSizings)
local TextButton = UIBlox.App.Button.TextButton
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize

return function(tbl1)
    local size200 = useStyle().Tokens.Size.Size_200
    local menuItemDimensions = getMenuItemDimensions(tbl1.menuWidth)
    local menuItemSizings = getMenuItemSizings()

    local menuItemHeightTight = Constants.MenuItemHeightTight

    local xOffset = math.max(
        tbl1.menuWidth - Constants.MenuItemDynamicWidthOffset,
        menuItemDimensions.LeftWidth + menuItemDimensions.RightWidth
    )
    local isSmallPortraitViewport = tbl1.isSmallPortraitViewport

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = if isSmallPortraitViewport then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = if isSmallPortraitViewport then UDim.new(0, size200) else UDim.new(0, 0)
        }),
        Label = React.createElement("TextLabel", {
            Text = tbl1.label,
            Font = AppFonts.default:getMedium(),
            LayoutOrder = 1,
            TextColor3 = Color3.new(1, 1, 1),
            TextTransparency = 0,
            TextSize = menuItemDimensions.TextSize,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = if isSmallPortraitViewport then UDim2.fromOffset(xOffset, 0) else UDim2.new(0, menuItemDimensions.LeftWidth, 0, Constants.MenuItemHeight),
            BackgroundTransparency = 1
        }),
        MiddleWidthHolder = if isSmallPortraitViewport then nil else React.createElement("Frame", {
            Size = UDim2.new(
                0,
                math.max(0, tbl1.menuWidth - menuItemDimensions.LeftWidth - menuItemDimensions.RightWidth - 100),
                0,
                Constants.MenuItemHeight
            ),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        }),
        Container = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = if isSmallPortraitViewport then UDim2.fromOffset(xOffset, menuItemHeightTight) else UDim2.new(0, menuItemDimensions.RightWidth, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }

    local tbl5 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = if isSmallPortraitViewport then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        LeftChevron = if tbl1.isSelectionDisabled then nil else React.createElement(IconButton, {
            size = UDim2.fromOffset(32, 32),
            iconSize = IconSize.Medium,
            icon = Images["icons/actions/cycleLeft"],
            onActivated = tbl1.onClickLeft,
            layoutOrder = 1
        }),
        ButtonContainer = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(0, menuItemDimensions.RightWidth - 64, 0, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        }, {
            ToggleButton = React.createElement(TextButton, {
                size = UDim2.new(1, 0, 1, 0),
                text = tbl1.abuseType,
                onActivated = tbl1.onClickRight,
                layoutOrder = 2,
                isDisabled = tbl1.isSelectionDisabled,
                fontStyle = menuItemSizings.FontStyle,
                verticalPadding = menuItemSizings.ButtonInsideVerticalPadding
            })
        }),
        RightChevron = if tbl1.isSelectionDisabled then nil else React.createElement(IconButton, {
            size = UDim2.fromOffset(32, 32),
            iconSize = IconSize.Medium,
            icon = Images["icons/actions/cycleRight"],
            onActivated = tbl1.onClickRight,
            layoutOrder = 3
        })
    }
    tbl3.Container = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end
