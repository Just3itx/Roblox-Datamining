-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local Foundation = require(GameFiltersParent.Foundation)
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local React = require(GameFiltersParent.React)
local Responsive = require(GameFiltersParent.Responsive)
local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag

return function(tbl1)
    local var1 = useTokens()
    local bool1 = Responsive.usePreferredInput() == Responsive.Input.Directional

    local headingSmall = var1.Typography.HeadingSmall
    local emphasis = var1.Color.Content.Emphasis

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = if FFlagLuaAppChartsFilterOptionTextTag then nil else UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.LayoutOrder
    }

    tbl2[React.Change.AbsoluteSize] = function(arg1)
        tbl1.onHeightChanged(arg1.AbsoluteSize.Y)
    end

    return createElement(str1, tbl2, {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var1.Padding.Medium),
            PaddingBottom = UDim.new(0, var1.Padding.Medium),
            PaddingLeft = UDim.new(0, var1.Padding.XXLarge),
            PaddingRight = UDim.new(0, var1.Padding.XXLarge)
        }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Title = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = 1,
            Text = tbl1.title,
            FontFace = normalizeFontFace(headingSmall.Font),
            TextSize = headingSmall.FontSize,
            TextColor3 = emphasis.Color3,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextWrapped = true
        }),
        CloseButton = if bool1 then nil else React.createElement(
            IconButton,
            {
                LayoutOrder = 2,
                icon = "icons/navigation/close",
                size = IconSize.Small,
                onActivated = tbl1.onCloseButtonActivated
            }
        )
    })
end
