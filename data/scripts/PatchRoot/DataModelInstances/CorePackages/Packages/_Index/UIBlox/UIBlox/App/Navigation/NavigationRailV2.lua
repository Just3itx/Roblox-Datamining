-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Cryo = require(scriptParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParent.React)
local ReactOtter = require(scriptParentParentParentParent.ReactOtter)
local _StyleTypes = require(scriptParentParent.Style.StyleTypes)
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local NavigationRailAlignment = require(scriptParentParent.Navigation.Enum.NavigationRailAlignment)

local tbl1 = {
    visible = true,
    isVisible = true,
    zIndex = 1,
    animated = false,
    animationConfig = { dampingRatio = 1, frequency = 3 }
}

local function NavigationRail(tbl2)
    assert(#tbl2.items > 0, "At least one item should be present!")
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local offset = if var1.paddings and var1.paddings.Top then var1.paddings.Top else var2.Tokens.Size.Size_150
    local offset2 = if var1.paddings and var1.paddings.Bottom then var1.paddings.Bottom else var2.Tokens.Size.Size_150
    local offset3 = if var1.paddings and var1.paddings.Left then var1.paddings.Left else var2.Tokens.Size.Size_150
    local offset4 = if var1.paddings and var1.paddings.Right then var1.paddings.Right else var2.Tokens.Size.Size_150
    local var3 = nil
    if var1.alignment == NavigationRailAlignment.Justified then
        var3 = Enum.VerticalAlignment.Top
    elseif var1.alignment == NavigationRailAlignment.Centered then
        var3 = Enum.VerticalAlignment.Center
    else
        error("NavigationRail alignment type is incorrect!")
    end

    local var4, var5 = React.useState(if var1.size then var1.size.X.Offset else 0)
    local var6 = React.useCallback(function(arg1)
        if var1.animated then
            var5(arg1.AbsoluteSize.X)
        end
    end, { var1.animated })

    local var7, var8 = ReactOtter.useAnimatedBinding(if var1.animated then if var1.isVisible then 0 else -var4 else 0)
    React.useEffect(function()
        if var1.animated then
            if var1.isVisible then
                var8(ReactOtter.spring(0, var1.animationConfig))
            else
                var8(ReactOtter.spring(-var4, var1.animationConfig))
            end
        end
        return nil
    end, {
        var1.animated,
        var1.isVisible,
        var4,
        var1.animationConfig
    })
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = var1.spacing,
            SortOrder = Enum.SortOrder.Name
        })
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = var1.spacing,
            SortOrder = Enum.SortOrder.Name
        })
    }
    local bool1 = false
    for i, item in ipairs(var1.items) do
        local bool2 = i == var1.selection
        if item.isSecondary then
            tbl4[tostring(i)] = var1.renderItem(item, bool2)
            bool1 = true
        else
            tbl3[tostring(i)] = var1.renderItem(item, bool2)
        end
    end

    local var9 = var7:map(function(num1: number)
        return UDim2.new(0, math.floor(num1 + 0.5), 0, 0)
    end)

    if var1.leadingComponent then
        tbl3["0"] = var1.leadingComponent
    end
    if var1.trailingComponent then
        tbl3[":"] = var1.trailingComponent
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl5 = {
        BackgroundTransparency = 1,
        ClipsDescendants = var1.clipsDescendants,
        Size = var1.size,
        Position = var1.position,
        Visible = var1.visible,
        ZIndex = var1.zIndex,
        [React.Change.AbsoluteSize] = var6
    }
    local tbl6 = { AnimatedFrame = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl7 = {
        Position = var9,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = if var1.backgroundColor then var1.backgroundColor.Color else var2.Theme.NavigationBar.Color,
        BackgroundTransparency = if var1.backgroundColor then var1.backgroundColor.Transparency else var2.Theme.NavigationBar.Transparency
    }

    local tbl8 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, offset),
            PaddingBottom = UDim.new(0, offset2),
            PaddingLeft = UDim.new(0, offset3),
            PaddingRight = UDim.new(0, offset4)
        }),
        MainFrame = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        }, {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = var3,
                Padding = UDim.new(0, var2.Tokens.Size.Size_400)
            }),
            PrimaryItems = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                },
                tbl3
            ),
            CenteredSecondaryItems = if bool1 and var1.alignment == NavigationRailAlignment.Centered then React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 2,
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                },
                tbl4
            ) else nil
        }),
        JustifiedSecondaryItems = if bool1 and var1.alignment == NavigationRailAlignment.Justified then React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, tbl4) else nil
    }
    tbl6.AnimatedFrame = createElement2(str2, tbl7, tbl8)
    return createElement(str1, tbl5, tbl6)
end

return NavigationRail
