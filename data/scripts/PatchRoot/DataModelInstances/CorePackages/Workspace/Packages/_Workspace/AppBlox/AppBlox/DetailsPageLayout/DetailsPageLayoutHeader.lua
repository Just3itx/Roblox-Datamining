-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)
local Responsive = require(AppBloxParent.Responsive)

local View = Foundation.View
local IconButton = Foundation.IconButton
local useTokens = Foundation.Hooks.useTokens
local useDeviceInsets = Responsive.useDeviceInsets

local DetailsPageLayoutContext = require(script.Parent.DetailsPageLayoutContext)

return React.memo(React.forwardRef(function(tbl1, ref) -- name: DetailsPageLayoutHeader
    local var1 = useTokens()
    local var2 = useDeviceInsets()
    local var3 = React.useContext(DetailsPageLayoutContext)
    local setHasHeader = var3.setHasHeader

    React.useEffect(function()
        setHasHeader(true)
        return function()
            setHasHeader(false)
        end
    end, { setHasHeader })

    local hasFullBleed = var3.hasFullBleed
    local headerBarHeight = var3.headerBarHeight
    local stickyHeaderActive = var3.stickyHeaderActive
    local headerOpacity = var3.headerOpacity
    local top = var2.top
    local onClose = var3.onClose
    local isFullscreenOverlay = var3.isFullscreenOverlay
    local onExitFullscreenOverlay = var3.onExitFullscreenOverlay
    local var4 = tbl1.closeIconName or Foundation.Enums.IconName.ChevronLargeLeft
    local var5 = tbl1.backgroundColor or var1.Color.Surface.Surface_0
    local var6 = Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small)
    local testId = var3.testId

    assert(testId, "DetailsPageLayout.Header must be used within DetailsPageLayout.Root")

    if isFullscreenOverlay then
        onClose = onExitFullscreenOverlay or onClose
    end

    if isFullscreenOverlay then
        var4 = Foundation.Enums.IconName.ChevronLargeLeft
    end

    if isFullscreenOverlay then
        headerOpacity = nil
    end

    local var7 = if hasFullBleed and headerOpacity then headerOpacity:map(function(num1: number): boolean
        return num1 >= 0.5
    end) else nil

    local var8 = tbl1.children and (hasFullBleed and headerOpacity or not hasFullBleed or stickyHeaderActive)
    local element = if onClose then React.createElement(IconButton, {
        variant = Foundation.Enums.ButtonVariant.Utility,
        size = if var6 then Foundation.Enums.InputSize.Medium else Foundation.Enums.InputSize.Large,
        icon = var4,
        onActivated = onClose,
        testId = if testId then `{testId}--close-button` else nil
    }) else nil
    local element2

    if tbl1.fullWidthContent then
        local createElement = React.createElement
        local var9 = View
        local tbl2 = { LayoutOrder = 1, tag = "fill size-full-0" }

        local tbl3 = { CloseButtonOverlay = 0, Children = 0 }
        local element3

        if element then
            element3 = React.createElement(View, {
                ZIndex = 2,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, if var6 then var1.Padding.Medium else var1.Padding.XLarge, 0.5, math.floor(top / 2)),
                tag = {
                    ["auto-xy radius-medium"] = tbl1.backgroundColor ~= nil,
                    ["auto-xy radius-medium bg-over-media-0"] = tbl1.backgroundColor == nil
                },
                backgroundStyle = tbl1.backgroundColor and {
                    Color3 = var5.Color3,
                    Transparency = var5.Transparency
                } or nil
            }, { CloseButton = element })
        else
            element3 = nil
        end

        tbl3.CloseButtonOverlay = element3

        tbl3.Children = if var8 then React.createElement(
            View,
            {
                Size = UDim2.new(1, 0, 1, -top),
                Position = UDim2.new(0, 0, 0, top),
                Visible = var7
            },
            {
                Content = React.createElement(React.Fragment, nil, tbl1.children)
            }
        ) else nil
        element2 = createElement(var9, tbl2, tbl3)
    else
        element2 = React.createElement(View, {
            LayoutOrder = 1,
            tag = {
                ["row align-y-center fill size-full-0 auto-y padding-x-medium"] = var6,
                ["row align-y-center fill size-full-0 auto-y padding-x-xlarge"] = not var6
            },
            padding = top > 0 and {
                top = UDim.new(0, top)
            } or nil
        }, {
            Container = if element then React.createElement(View, {
                tag = {
                    ["auto-xy radius-medium"] = tbl1.backgroundColor ~= nil,
                    ["auto-xy radius-medium bg-over-media-0"] = tbl1.backgroundColor == nil
                },
                backgroundStyle = tbl1.backgroundColor and {
                    Color3 = var5.Color3,
                    Transparency = var5.Transparency
                } or nil
            }, { CloseButton = element }) else nil,
            Children = if var8 then React.createElement(
                View,
                { tag = "fill auto-y", LayoutOrder = 1, Visible = var7 },
                {
                    Content = React.createElement(React.Fragment, nil, tbl1.children)
                }
            ) else nil
        })
    end

    local createElement = React.createElement
    local var9 = View

    local tbl2 = {
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, headerBarHeight),
        tag = "col",
        backgroundStyle = not (hasFullBleed and headerOpacity) and {
            Color3 = var5.Color3,
            Transparency = var5.Transparency
        }
            or headerOpacity:map(function(num1: number)
                return {
                    Color3 = var5.Color3,
                    Transparency = math.lerp(1, var5.Transparency, num1)
                }
            end),
        ref = ref
    }

    local tbl3 = {
        HeaderContent = element2,
        BottomBorder = React.createElement(View, {
            LayoutOrder = 2,
            backgroundStyle = not headerOpacity and {
                Color3 = var1.Color.Stroke.Muted.Color3,
                Transparency = var1.Color.Stroke.Muted.Transparency
            }
                or headerOpacity:map(function(num1: number)
                    return {
                        Color3 = var1.Color.Stroke.Muted.Color3,
                        Transparency = math.lerp(1, var1.Color.Stroke.Muted.Transparency, num1)
                    }
                end),
            testId = if testId then `{testId}--header--bottom-border` else nil,
            Size = UDim2.new(1, 0, 0, var1.Stroke.Standard)
        })
    }

    return createElement(var9, tbl2, tbl3)
end))
