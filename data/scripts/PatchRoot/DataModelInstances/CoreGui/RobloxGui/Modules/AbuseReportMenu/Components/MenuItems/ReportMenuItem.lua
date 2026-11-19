-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local TextService = game:GetService("TextService")
local CorePackages = game:GetService("CorePackages")
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local UIBlox = require(CorePackages.Packages.UIBlox)

local Cryo = require(CorePackages.Packages.Cryo)
local React = require(CorePackages.Packages.React)
local useStyle = UIBlox.Core.Style.useStyle
local Constants = require(AbuseReportMenu.Components.Constants)
local getMenuItemDimensions = require(AbuseReportMenu.Components.getMenuItemDimensions)

local function DropdownReportMenuItem(arg1)
    local var1 = useStyle()
    local offset = if arg1.label == "" or arg1.isRightComponentFullWidth then 0 else var1.Tokens.Size.Size_150
    local theme = var1.Theme

    local menuItemDimensions = getMenuItemDimensions(arg1.menuContainerWidth)
    local xOffset = math.max(
        arg1.menuContainerWidth - Constants.MenuItemDynamicWidthOffset,
        menuItemDimensions.LeftWidth + menuItemDimensions.RightWidth
    )

    local yOffset, var2 = React.useState(var1.Tokens.Size.Size_1000)
    React.useEffect(function()
        local var3 = var2
        local size1000 = var1.Tokens.Size.Size_1000
        local textService = TextService
        local label = arg1.label
        local textSize = menuItemDimensions.TextSize
        local medium = AppFonts.default:getMedium()
        local new = Vector2.new
        local var4 = if arg1.isSmallPortraitViewport then xOffset else menuItemDimensions.LeftWidth
        var3(math.max(size1000, textService:GetTextSize(label, textSize, medium, new(var4, math.huge)).Y))
    end, {})

    local tbl1 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = if arg1.isSmallPortraitViewport then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = if arg1.isSmallPortraitViewport then UDim.new(0, offset) else UDim.new(0, 0)
        }),
        Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, offset), PaddingBottom = UDim.new(0, offset) })
    }
    local var3

    if arg1.isRightComponentFullWidth then
        local xOffset2 = math.max(
            arg1.menuContainerWidth - Constants.MenuItemDynamicWidthOffset,
            menuItemDimensions.LeftWidth + menuItemDimensions.RightWidth
        )
        var3 = Cryo.Dictionary.join(tbl1, {
            RightComponentWrapper = React.createElement("Frame", {
                Size = UDim2.new(0, xOffset2, 0, Constants.MenuItemHeight),
                BackgroundTransparency = 1,
                LayoutOrder = 3,
                AutomaticSize = Enum.AutomaticSize.Y
            }, {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }
                ),
                RightComponent = arg1.rightComponent
            })
        })
    else
        local xOffset2 = math.max(
            0,
            arg1.menuContainerWidth - menuItemDimensions.LeftWidth - menuItemDimensions.RightWidth - Constants.MenuItemDynamicWidthOffset
        )
        local join = Cryo.Dictionary.join
        local tbl2 = { Label = 0, MiddleSpaceHolder = 0, RightComponentWrapper = 0 }
        local element

        if arg1.label == "" and arg1.isSmallPortraitViewport then
            element = nil
        else
            element = React.createElement("TextLabel", {
                Text = arg1.label,
                Font = AppFonts.default:getMedium(),
                LayoutOrder = 1,
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                TextSize = menuItemDimensions.TextSize,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = if arg1.isSmallPortraitViewport then UDim2.new(0, xOffset, 0, 0) else UDim2.new(0, menuItemDimensions.LeftWidth, 0, yOffset),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            })
        end

        tbl2.Label = element

        tbl2.MiddleSpaceHolder = if arg1.isSmallPortraitViewport then nil else React.createElement(
            "Frame",
            {
                Size = UDim2.new(0, xOffset2, 0, Constants.MenuItemHeight),
                BackgroundTransparency = 1,
                LayoutOrder = 2
            }
        )

        local createElement = React.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = if arg1.isSmallPortraitViewport then UDim2.new(0, xOffset, 0, 0) else UDim2.new(0, menuItemDimensions.RightWidth, 0, Constants.MenuItemHeight),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 3
        }

        local tbl4 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = if arg1.isSmallPortraitViewport then Enum.HorizontalAlignment.Left else nil
            }),
            RightComponent = arg1.rightComponent
        }
        tbl2.RightComponentWrapper = createElement(str1, tbl3, tbl4)
        var3 = join(tbl1, tbl2)
    end

    if arg1.heightOverride then
        yOffset = arg1.heightOverride
    end

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, yOffset),
        AutomaticSize = if arg1.isRightComponentFullWidth or arg1.isSmallPortraitViewport then Enum.AutomaticSize.Y else nil,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder
    }, var3)
end

return DropdownReportMenuItem
