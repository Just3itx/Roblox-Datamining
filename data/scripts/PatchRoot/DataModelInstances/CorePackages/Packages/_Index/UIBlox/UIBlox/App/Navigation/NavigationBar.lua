-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:39Z
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
local NavigationBarAlignment = require(scriptParentParent.Navigation.Enum.NavigationBarAlignment)

local tbl1 = {
    visible = true,
    zIndex = 1,
    animated = false,
    maxWidth = 600,
    animationConfig = { dampingRatio = 1, frequency = 3 }
}

local function NavigationBar(tbl2)
    assert(#tbl2.items > 0, "At least one item should be present!")
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3, var4 = React.useState(if var1.size then var1.size.Y.Offset else 0)
    local offset = if var1.paddings and var1.paddings.Top then var1.paddings.Top else var2.Tokens.Size.Size_150
    local offset2 = if var1.paddings and var1.paddings.Bottom then var1.paddings.Bottom else var2.Tokens.Size.Size_150
    local offset3 = if var1.paddings and var1.paddings.Left then var1.paddings.Left else var2.Tokens.Size.Size_150
    local offset4 = if var1.paddings and var1.paddings.Right then var1.paddings.Right else var2.Tokens.Size.Size_150
    local var5 = nil
    local spaceAround = nil
    if var1.alignment == NavigationBarAlignment.Left then
        var5 = Enum.HorizontalAlignment.Left
    elseif var1.alignment == NavigationBarAlignment.EvenlyDistributed then
        spaceAround = Enum.UIFlexAlignment.SpaceAround
        var5 = Enum.HorizontalAlignment.Center
    else
        error("NavigationBar Alignment type is incorrect!")
    end

    local var6 = React.useCallback(function(arg1)
        if var1.visibility or var1.animated then
            var4(arg1.AbsoluteSize.Y)
        end
    end, { var1.visibility, var1.animated })
    local var7, var8 = ReactOtter.useAnimatedBinding(0)
    React.useEffect(function()
        if not var1.visibility and var1.animated then
            if var1.isVisible then
                var8(ReactOtter.spring(0, var1.animationConfig))
            else
                var8(ReactOtter.spring(var3, var1.animationConfig))
            end
        end
        return nil
    end, {
        var1.visibility,
        var1.animated,
        var1.isVisible,
        var3,
        var1.animationConfig
    })
    local tbl3 = {
        Constraint = if var1.maxWidth == nil then nil else React.createElement("UISizeConstraint", { MaxSize = Vector2.new(var1.maxWidth, math.huge) }),
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, offset),
            PaddingBottom = UDim.new(0, offset2),
            PaddingLeft = UDim.new(0, offset3),
            PaddingRight = UDim.new(0, offset4)
        }),
        Layout = React.createElement("UIListLayout", {
            Padding = var1.spacing,
            SortOrder = Enum.SortOrder.Name,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = spaceAround,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        })
    }
    for i, item in ipairs(var1.items) do
        local bool1 = i == var1.selection
        tbl3[tostring(i)] = var1.renderItem(item, bool1)
    end

    local var9 = if var1.visibility then var1.visibility:map(function(num1: number)
        local var9 = (1 - num1) * var3
        return UDim2.new(0, 0, 0, math.floor(var9 + 0.5))
    end) else var7:map(function(num1: number)
        return UDim2.new(0, 0, 0, math.floor(num1 + 0.5))
    end)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        ClipsDescendants = var1.clipsDescendants,
        Size = var1.size,
        AutomaticSize = var1.automaticSize,
        Position = var1.position,
        Visible = var1.visible,
        [React.Change.AbsoluteSize] = var6
    }
    local tbl5 = {
        AnimatedFrame = React.createElement("Frame", {
            Active = var1.active,
            Position = var9,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            AutomaticSize = var1.automaticSize,
            BackgroundColor3 = if var1.backgroundColor then var1.backgroundColor.Color else var2.Theme.NavigationBar.Color,
            BackgroundTransparency = if var1.backgroundColor then var1.backgroundColor.Transparency else var2.Theme.NavigationBar.Transparency,
            Selectable = false,
            Visible = var1.visible,
            ZIndex = var1.zIndex
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                HorizontalAlignment = var5
            }),
            InnerFrame = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    AutomaticSize = var1.automaticSize
                },
                tbl3
            )
        })
    }
    return createElement(str1, tbl4, tbl5)
end

return NavigationBar
