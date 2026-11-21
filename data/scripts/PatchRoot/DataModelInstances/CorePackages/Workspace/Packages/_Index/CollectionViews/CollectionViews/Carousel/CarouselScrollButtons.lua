-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local React = require(CollectionViewsParent.React)
local ReactIs = require(CollectionViewsParent.ReactIs)

local Foundation = require(CollectionViewsParent.Foundation)
local ControlState = Foundation.Enums.ControlState
local IconSize = Foundation.Enums.IconSize
local Icon = Foundation.Icon
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function ScrollButton(tbl1)
    local var1 = useTokens()
    local onStateChanged = React.useCallback(function(arg1)
        if arg1 == ControlState.Hover or arg1 == ControlState.Pressed then
            if tbl1.onScrollButtonEnter then
                tbl1.onScrollButtonEnter()
            end
        elseif tbl1.onScrollButtonLeave then
            tbl1.onScrollButtonLeave()
        end
    end, { tbl1.onScrollButtonEnter, tbl1.onScrollButtonLeave })

    return React.createElement(View, {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Visible = tbl1.Visible,
        onStateChanged = onStateChanged,
        onActivated = tbl1.onActivated,
        tag = "size-1000 radius-circle bg-over-media-100"
    }, {
        Icon = React.createElement(Icon, {
            name = tbl1.icon,
            size = IconSize.Large,
            style = var1.Color.Content.Emphasis,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5)
        })
    })
end

local function CarouselScrollButtons(tbl1)
    local buttonOffsetFromEdge = tbl1.buttonOffsetFromEdge or 0

    local var1, var2 = React.useState(false)

    local var3 = if ReactIs.isBinding(tbl1.leftScrollingEnabled) then tbl1.leftScrollingEnabled:map(function(bool1: boolean)
        return var1 and bool1
    end) else var1 and tbl1.leftScrollingEnabled

    local var4 = if ReactIs.isBinding(tbl1.rightScrollingEnabled) then tbl1.rightScrollingEnabled:map(function(bool1: boolean)
        return var1 and bool1
    end) else var1 and tbl1.rightScrollingEnabled

    local var5 = React.useCallback(function()
        var2(true)
    end, {})
    local var6 = React.useCallback(function()
        var2(false)
    end, {})

    return React.createElement("Frame", {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Size = tbl1.Size,
        ZIndex = tbl1.ZIndex or 10,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        [React.Event.MouseEnter] = var5,
        [React.Event.MouseLeave] = var6
    }, {
        LeftScrollButton = React.createElement(ScrollButton, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, buttonOffsetFromEdge, 0.5, 0),
            Visible = var3,
            icon = "chevron-large-left",
            onScrollButtonEnter = tbl1.onScrollButtonEnter,
            onScrollButtonLeave = tbl1.onScrollButtonLeave,
            onActivated = tbl1.handleScrollLeft
        }),
        RightScrollButton = React.createElement(ScrollButton, {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -buttonOffsetFromEdge, 0.5, 0),
            Visible = var4,
            icon = "chevron-large-right",
            onScrollButtonEnter = tbl1.onScrollButtonEnter,
            onScrollButtonLeave = tbl1.onScrollButtonLeave,
            onActivated = tbl1.handleScrollRight
        })
    })
end

return CarouselScrollButtons
