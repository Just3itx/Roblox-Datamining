-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamepadService = game:GetService("GamepadService")

local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local ReactOtter = require(AvatarExperienceUIKitParent.ReactOtter)
local useAnimatedBinding = ReactOtter.useAnimatedBinding
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local ScrollingFrameWithIndicators = require(AvatarExperienceUIKit.ScrollingFrameWithIndicators.ScrollingFrameWithIndicators)
local makeOtterSpringValue = require(AvatarExperienceUIKit.Utils.makeOtterSpringValue)
local getCenterScrollOffset = require(AvatarExperienceUIKit.Utils.getCenterScrollOffset)
local getRevealScrollOffset = require(AvatarExperienceUIKit.Utils.getRevealScrollOffset)
local AvatarExperienceFlags = require(AvatarExperienceUIKitParent.AvatarExperienceFlags)
local FFlagAXCategoryMenuVisualFixes = AvatarExperienceFlags.FFlagAXCategoryMenuVisualFixes
local FFlagAXScrollHighlightedTabIntoView = AvatarExperienceFlags.FFlagAXScrollHighlightedTabIntoView
local FFlagAXTabGroupScrollOnlyWhenClipped = AvatarExperienceFlags.FFlagAXTabGroupScrollOnlyWhenClipped

local backgroundStyle = { Transparency = 1 }

local TabGroupTab = require(script.Parent.TabGroupTab)

local layout = {
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalFlex = Enum.UIFlexAlignment.None
}
local tbl1 = { Transparency = 1 }

local tbl4 = { dampingRatio = 1, frequency = 5 }

local function getActiveTabPosition(xOffset: number): UDim2
    return UDim2.new(0, xOffset, 1, 0)
end

local function getActiveTabSize(xOffset: number): UDim2
    return UDim2.new(0, xOffset, 0, 3)
end

return React.forwardRef(function(tbl5, ref) -- name: TabGroup
    local var1 = useTokens()
    local var2, var3 = useAnimatedBinding(0)
    local var4, var5 = useAnimatedBinding(0)

    local var6 = React.useRef(nil)
    local var7 = React.useRef(nil)
    local controllerRef = React.useRef(nil)
    local var9 = if FFlagAXTabGroupScrollOnlyWhenClipped then React.useRef(nil) else nil

    local var10 = React.useCallback(function(num1: number, num2: number, bool1: boolean?)
        if not bool1 and (not FFlagAXCategoryMenuVisualFixes or var4:getValue() > 0) then
            var3(makeOtterSpringValue(num1, tbl4))
            var5(makeOtterSpringValue(num2, tbl4))
            return
        end
        var3(ReactOtter.instant(num1))
        var5(ReactOtter.instant(num2))
    end, {})

    local var11 = React.useCallback(function()
        local current = controllerRef.current
        local current2 = var6.current
        local current3 = var7.current
        if not (current and current2 and current3) then
            return
        end

        local scrollingFrame = current.getScrollingFrame()
        if not scrollingFrame then
            return
        end

        local x = if FFlagAXTabGroupScrollOnlyWhenClipped then scrollingFrame.AbsoluteWindowSize.X else scrollingFrame.AbsoluteSize.X

        if x <= 0 then
            return
        end

        local canvasPositionX = scrollingFrame.CanvasPosition.X
        local var11 = if FFlagAXTabGroupScrollOnlyWhenClipped then current3.AbsolutePosition.X - scrollingFrame.AbsolutePosition.X + canvasPositionX else current3.AbsolutePosition.X - current2.AbsolutePosition.X

        if not (FFlagAXTabGroupScrollOnlyWhenClipped and var9) then
            local var12 = var11 + current3.AbsoluteSize.X

            if var11 < canvasPositionX then
                current.scrollToOffset(var11)
                return
            end

            if canvasPositionX + x < var12 then
                current.scrollToOffset(var12 - x)
            end
            return
        end

        local absoluteSizeX = current3.AbsoluteSize.X
        local absoluteCanvasSizeX = scrollingFrame.AbsoluteCanvasSize.X
        local obscuredEdgeInset = current.getObscuredEdgeInset()

        local revealScrollOffset = getRevealScrollOffset(var11, absoluteSizeX, canvasPositionX, x, absoluteCanvasSizeX, obscuredEdgeInset)
        if revealScrollOffset ~= nil then
            var9.current = revealScrollOffset
            current.scrollToOffset(revealScrollOffset)
            return
        end

        local scrollTarget = current.getScrollTarget()
        if scrollTarget ~= nil
            and scrollTarget == var9.current
            and getRevealScrollOffset(var11, absoluteSizeX, scrollTarget, x, absoluteCanvasSizeX, obscuredEdgeInset) ~= nil
        then
            current.setOffset(canvasPositionX)
        end
    end, {})

    local var12 = if FFlagAXScrollHighlightedTabIntoView then React.useCallback(function(arg1)
        local current = controllerRef.current
        if not current then
            return
        end

        local scrollingFrame = current.getScrollingFrame()
        if not scrollingFrame or not arg1 or not arg1:IsDescendantOf(game) or not arg1:IsDescendantOf(scrollingFrame) then
            return
        end

        local absoluteWindowSizeX = scrollingFrame.AbsoluteWindowSize.X
        local canvasPositionX = scrollingFrame.CanvasPosition.X
        local var12 = arg1.AbsolutePosition.X - scrollingFrame.AbsolutePosition.X + canvasPositionX

        local centerScrollOffset = getCenterScrollOffset(var12, arg1.AbsoluteSize.X, canvasPositionX, absoluteWindowSizeX)
        if centerScrollOffset == nil then
            return
        end

        current.scrollToOffset(centerScrollOffset)
    end, {}) else nil

    local var13 = React.useCallback(function(current)
        local current2 = var6.current
        var7.current = current

        for _, item in tbl5.items do
            if item.id == tbl5.activeTabId and item.ref then
                item.ref.current = current
            end
        end

        if not current or not current2 then
            return
        end

        local var13 = current.AbsolutePosition.X - current2.AbsolutePosition.X
        local absoluteSizeX = current.AbsoluteSize.X
        var10(var13, absoluteSizeX)

        if FFlagAXScrollHighlightedTabIntoView and not FFlagAXTabGroupScrollOnlyWhenClipped and var12 then
            var12(current)
            return
        end
        var11()
    end, {
        tbl5.activeTabId,
        tbl5.items,
        var11,
        var12,
        var10
    })

    React.useEffect(function()
        local current = var6.current
        local current2 = var7.current
        if not current2 or not current then
            return
        end

        local var14 = current2.AbsolutePosition.X - current.AbsolutePosition.X
        local absoluteSizeX = current2.AbsoluteSize.X

        var10(var14, absoluteSizeX, FFlagAXCategoryMenuVisualFixes)

        if FFlagAXScrollHighlightedTabIntoView and not FFlagAXTabGroupScrollOnlyWhenClipped and var12 then
            var12(current2)
            return
        end
        var11()
    end, { var11, var12, var10 })

    if FFlagAXScrollHighlightedTabIntoView then
        React.useEffect(function()
            local current = controllerRef.current
            if not current then
                return
            end

            local scrollingFrame = current.getScrollingFrame()
            if not scrollingFrame then
                return
            end

            local connection = scrollingFrame.SelectionChanged:Connect(function(_: boolean, _, arg1)
                if GamepadService.GamepadCursorEnabled then
                    return
                end
                if var12 then
                    var12(arg1)
                end
            end)

            return function()
                connection:Disconnect()
            end
        end, {})
    end

    if FFlagAXCategoryMenuVisualFixes then
        React.useEffect(function()
            local bool1 = false
            if tbl5.activeTabId ~= nil then
                for _, item in tbl5.items do
                    if item.id == tbl5.activeTabId then
                        bool1 = true
                        break
                    end
                end
            end

            if not bool1 then
                var7.current = nil
                var3(ReactOtter.instant(0))
                var5(ReactOtter.instant(0))
            end
        end, { tbl5.activeTabId, tbl5.items })

        React.useImperativeHandle(tbl5.controllerRef, function()
            return {
                scrollToOffset = function(num1: number)
                    local current = controllerRef.current
                    if current then
                        current.scrollToOffset(num1)
                    end
                end,
                setOffset = function(num1: number)
                    local current = controllerRef.current
                    if current then
                        current.setOffset(num1)
                    end
                end,
                getScrollingFrame = function()
                    local current = controllerRef.current
                    if current then
                        return (current.getScrollingFrame())
                    end

                    return nil
                end,
                getScrollTarget = function()
                    local current = controllerRef.current
                    if current then
                        return (current.getScrollTarget())
                    end

                    return nil
                end,
                getObscuredEdgeInset = function()
                    local current = controllerRef.current
                    if current then
                        return (current.getObscuredEdgeInset())
                    end

                    return 0
                end
            }
        end, {})
    end

    local tbl6 = ({})
    for layoutOrder, item in tbl5.items do
        local isActive = tbl5.activeTabId == item.id
        local id = item.id

        tbl6[id] = React.createElement(TabGroupTab, {
            ref = if isActive then var13 else item.ref,
            text = item.text,
            onActivated = tbl5.onTabActivated and function()
                tbl5.onTabActivated(item.id)
            end or nil,
            isActive = isActive,
            fontStyle = tbl5.tabFontStyle,
            padding = tbl5.tabPadding,
            textStyle = tbl5.tabTextStyle,
            activeTextStyle = tbl5.tabActiveTextStyle,
            LayoutOrder = layoutOrder
        })
    end

    local var14 = React.useMemo(function()
        return var2:map(getActiveTabPosition)
    end, {})

    local var15 = React.useMemo(function()
        return var4:map(getActiveTabSize)
    end, {})

    local innerNavigation = React.createElement(View, {
        ref = var6,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        backgroundStyle = tbl1,
        layout = layout,
        ZIndex = -1
    }, tbl6)

    local activeTabIndicator = React.createElement("Frame", {
        Position = var14,
        Size = var15,
        BackgroundColor3 = var1.Color.Content.Emphasis.Color3,
        AnchorPoint = Vector2.new(0, 1),
        BorderSizePixel = 0
    })

    return React.createElement(
        ScrollingFrameWithIndicators,
        {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = tbl5.BackgroundTransparency,
            BackgroundColor3 = tbl5.BackgroundColor3,
            LayoutOrder = tbl5.LayoutOrder,
            Position = tbl5.Position,
            ZIndex = tbl5.ZIndex,
            ref = ref,
            controllerRef = controllerRef
        },
        FFlagAXCategoryMenuVisualFixes
            and {
                Content = React.createElement(
                    View,
                    {
                        Size = UDim2.fromScale(0, 0),
                        AutomaticSize = Enum.AutomaticSize.XY,
                        backgroundStyle = backgroundStyle
                    },
                    { InnerNavigation = innerNavigation, ActiveTabIndicator = activeTabIndicator }
                )
            }
            or { InnerNavigation = innerNavigation, ActiveTabIndicator = activeTabIndicator }
    )
end)
