-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local Dash = require(scriptParentParentParent.Dash)
local Foundation = require(scriptParentParentParent.Foundation)
local ScrollView = Foundation.ScrollView
local View = Foundation.View
local useDesignTokens = require(scriptParentParentParent.Style).useDesignTokens
local UIBlox = require(scriptParentParentParent.UIBlox)
local BaseMenu = UIBlox.App.Menu.BaseMenu
local useCursor = UIBlox.App.SelectionCursor.useCursor

local PlayerContextualMenuHeader = require(script.Parent.PlayerContextualMenuHeader)

local FFlagPlayerContextualMenuFitToViewport = require(scriptParentParent.Flags.FFlagPlayerContextualMenuFitToViewport)

local function noop() end

local tbl1 = {
    width = UDim.new(1, 0)
}

local function getCardLayout(tbl2, tbl3)
    local var1 = if tbl2.scaleReference > 0 then tbl2.scaleReference / 100 else 1
    local var2 = tbl2.container / var1
    local var3 = tbl2.content / var1

    local var4 = tbl3.minScrollHeight + tbl3.cornerRadius * 2
    local huge = if var2 > 0 then math.max(var2 - tbl3.viewportMargin * 2, var4) else math.huge
    local isOverflowing = huge < var3
    local tbl4 = {
        isContentMeasured = var3 > 0,
        isOverflowing = isOverflowing,
        height = 0,
        inset = 0
    }

    if not isOverflowing then
        huge = var3
    end

    tbl4.height = huge

    tbl4.inset = if isOverflowing then tbl3.cornerRadius else 0
    return tbl4
end

local function useFitToViewport(viewportMargin: number, cornerRadius: number, minScrollHeight: number)
    local var1 = React.useMemo(function()
        return {
            viewportMargin = viewportMargin,
            cornerRadius = cornerRadius,
            minScrollHeight = minScrollHeight
        }
    end, { viewportMargin, cornerRadius, minScrollHeight })

    local var2, var3 = React.useBinding({ container = 0, content = 0, scaleReference = 0 })

    local isOverflowing, var5 = React.useState(false)

    local var6 = React.useCallback(function(tbl2)
        local var6 = Dash.join(var2:getValue(), tbl2)
        var3(var6)
        var5(getCardLayout(var6, var1).isOverflowing)
    end, { var2, var1 })

    local onContainerAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6({ container = arg1.AbsoluteSize.Y })
    end, { var6 })

    local onContentAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6({ content = arg1.AbsoluteSize.Y })
    end, { var6 })

    local onScaleReferenceAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6({ scaleReference = arg1.AbsoluteSize.Y })
    end, { var6 })

    local var10 = React.useMemo(function()
        return var2:map(function(tbl2)
            return (getCardLayout(tbl2, var1))
        end)
    end, { var2, var1 })

    return {
        isOverflowing = isOverflowing,
        automaticSize = React.useMemo(function()
            return var10:map(function(tbl2): Enum.AutomaticSize
                return if tbl2.isContentMeasured then Enum.AutomaticSize.None else Enum.AutomaticSize.Y
            end)
        end, { var10 }),
        scrollViewSize = React.useMemo(function()
            return var10:map(function(tbl2): UDim2
                return UDim2.new(1, 0, 0, if tbl2.isContentMeasured then tbl2.height - tbl2.inset * 2 else 0)
            end)
        end, { var10 }),
        inset = React.useMemo(function()
            return var10:map(function(tbl2): UDim
                return UDim.new(0, tbl2.inset)
            end)
        end, { var10 }),
        onContainerAbsoluteSizeChanged = onContainerAbsoluteSizeChanged,
        onContentAbsoluteSizeChanged = onContentAbsoluteSizeChanged,
        onScaleReferenceAbsoluteSizeChanged = onScaleReferenceAbsoluteSizeChanged
    }
end

return function(tbl2)
    local var1 = Dash.join(tbl1, tbl2)
    local selectionImageObject = useCursor()
    local var3 = useDesignTokens(function(arg1)
        return {
            overlayBackgroundColor3 = arg1.Color.Common.Scrim.Color3,
            overlayBackgroundTransparency = arg1.Color.Common.Scrim.Transparency,
            backgroundColor = arg1.Color.Surface.Surface_0.Color3,
            backgroundTransparency = arg1.Color.Surface.Surface_0.Transparency,
            menuCornerRadius = arg1.Radius.Medium,
            viewportMargin = arg1.Size.Size_400,
            minScrollHeight = arg1.Size.Size_1400
        }
    end)

    local headerHeight, onHeaderHeightChanged = React.useState(0)
    local var6 = if FFlagPlayerContextualMenuFitToViewport then useFitToViewport(var3.viewportMargin, var3.menuCornerRadius, var3.minScrollHeight) else nil

    local renderHeader = React.useCallback(function()
        return React.createElement(
            PlayerContextualMenuHeader,
            Dash.join(var1.headerProps, { onHeaderHeightChanged = onHeaderHeightChanged })
        )
    end, { var1.headerProps })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = var3.overlayBackgroundColor3,
        BackgroundTransparency = var3.overlayBackgroundTransparency,
        ZIndex = -1,
        [React.Change.AbsoluteSize] = if var6 then var6.onContainerAbsoluteSizeChanged else nil
    }
    local tbl4 = {
        ScaleReference = if var6 then React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(0, 100),
            [React.Change.AbsoluteSize] = var6.onScaleReferenceAbsoluteSizeChanged
        }) else nil,
        PositionFrame = 0
    }

    local createElement2 = React.createElement
    local str2 = "TextButton"
    local tbl5 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutoButtonColor = false,
        BackgroundColor3 = var3.backgroundColor,
        BackgroundTransparency = var3.backgroundTransparency,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Selectable = #var1.buttonProps == 0,
        SelectionImageObject = selectionImageObject,
        Size = UDim2.new(var1.width, UDim.new(0, 0)),
        Text = "",
        ZIndex = 0
    }

    local tbl6 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var3.menuCornerRadius) }),
        CardPadding = if var6 then React.createElement("UIPadding", { PaddingTop = var6.inset, PaddingBottom = var6.inset }) else nil,
        BaseMenu = if var6 then nil else React.createElement(BaseMenu, {
            topElementRounded = false,
            buttonProps = var1.buttonProps,
            width = var1.width,
            enableTokenOverride = true,
            renderHeader = renderHeader,
            headerHeight = headerHeight
        }),
        CardScrollView = 0
    }
    local element2

    if var6 then
        element2 = React.createElement(ScrollView, {
            AutomaticSize = var6.automaticSize,
            Size = var6.scrollViewSize,
            scroll = {
                AutomaticSize = var6.automaticSize,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(),
                ScrollingDirection = Enum.ScrollingDirection.Y
            },
            selection = { Selectable = false }
        }, {
            Content = React.createElement(
                View,
                {
                    tag = "col size-full-0 auto-y",
                    onAbsoluteSizeChanged = var6.onContentAbsoluteSizeChanged
                },
                {
                    HeaderFrame = React.createElement(View, {
                        LayoutOrder = 1,
                        tag = "size-full-0 auto-y"
                    }, {
                        Header = React.createElement(PlayerContextualMenuHeader, Dash.join(var1.headerProps, { onHeaderHeightChanged = noop }))
                    }),
                    BaseMenu = React.createElement(BaseMenu, {
                        topElementRounded = false,
                        bottomElementRounded = not var6.isOverflowing,
                        buttonProps = var1.buttonProps,
                        width = var1.width,
                        enableTokenOverride = true,
                        layoutOrder = 2
                    })
                }
            )
        })
    else
        element2 = nil
    end

    tbl6.CardScrollView = element2
    tbl4.PositionFrame = createElement2(str2, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end
