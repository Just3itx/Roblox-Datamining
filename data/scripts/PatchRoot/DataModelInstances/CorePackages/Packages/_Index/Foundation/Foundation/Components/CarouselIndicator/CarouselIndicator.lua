-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)
local useRefCache = require(FoundationParent.ReactUtils).useRefCache

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Dot = require(script.Parent.Dot)
local getCarouselIndicatorDotsConfig = require(script.Parent.getCarouselIndicatorDotsConfig)

local function getDotCenter(dots, num1: number, size100: number)
    local num2 = math.max(#dots - 1, 0) * size100
    local num3 = 0

    for k, dot in dots do
        num2 += dot.size

        if k < num1 then
            num3 += dot.size + size100
        elseif k == num1 then
            num3 += dot.size / 2
        end
    end

    return num3 - num2 / 2
end

local tbl1 = { page = 1, count = 5, testId = "--foundation-carousel-indicator" }

return React.memo(React.forwardRef(function(arg1, arg2) -- name: CarouselIndicator
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local count = var1.count
    local size100 = var2.Size.Size_100
    local size200 = var2.Size.Size_200
    local size100_2 = var2.Size.Size_100
    local num1 = math.min(5, count)
    local xOffset = num1 * size200 + (num1 - 1) * size100

    local current = React.useMemo(function()
        return getCarouselIndicatorDotsConfig(size200, size100_2, var1.page, count)
    end, {
        size200,
        size100_2,
        var1.page,
        count
    })
    local var4 = React.useRef(nil)

    local var5, var6 = ReactOtter.useAnimatedBinding(0)
    local var7 = useRefCache()

    local var8 = React.useMemo(function()
        return {
            easingStyle = var2.Ease.StandardOut,
            duration = var2.Time.Time_200
        }
    end, { var2 })

    React.useEffect(function()
        local current2 = var4.current
        var4.current = current

        if not current2 or current2.count ~= current.count or current2.page == current.page then
            var6((ReactOtter.instant(0)))

            return
        end

        local var9 = current.page - current2.page
        local num2 = math.clamp(current2.activeVisibleIndex + var9, 1, #current2.dots)
        local var10 = getDotCenter(current2.dots, num2, size100) - getDotCenter(current.dots, current.activeVisibleIndex, size100)

        var6(
            ReactOtter.ease(
                0,
                {
                    easingStyle = var8.easingStyle,
                    duration = var8.duration,
                    startingValue = var5:getValue() + var10
                }
            )
        )
    end, { current, size100, var8 })

    local colorEaseConfig = React.useMemo(function()
        return {
            easingStyle = var2.Ease.Linear,
            duration = var2.Time.Time_100
        }
    end, { var2 })

    local scaleEaseConfig = React.useMemo(function()
        return {
            easingStyle = var2.Ease.StandardOut,
            duration = var2.Time.Time_300
        }
    end, { var2 })

    React.useImperativeHandle(arg2, function()
        if not var1.onActivated then
            return nil
        end

        local page = nil

        for _, dot in current.dots do
            if not dot.isActive then
                page = dot.page
                break
            end
        end

        return if page then var7[page].current else nil
    end, { var7, current.dots, var1.onActivated })

    local tbl2 = ({})
    for layoutOrder, dot in current.dots do
        local dot2 = current.dots[layoutOrder - 1]
        local dot3 = current.dots[layoutOrder + 1]
        if dot2 and dot2.isActive then
            dot2 = current.dots[layoutOrder - 2]
        end
        if dot3 and dot3.isActive then
            dot3 = current.dots[layoutOrder + 2]
        end
        local str1 = `Page{dot.page}`
        tbl2[str1] = React.createElement(Dot, {
            LayoutOrder = layoutOrder,
            scale = dot.size / size200,
            isActive = dot.isActive,
            maxSize = size200,
            page = dot.page,
            scaleEaseConfig = scaleEaseConfig,
            colorEaseConfig = colorEaseConfig,
            onActivated = if dot.isActive then nil else var1.onActivated,
            Selectable = not dot.isActive and var1.onActivated ~= nil,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = if dot2 == nil then var1.NextSelectionLeft else var7[dot2.page],
            NextSelectionRight = if dot3 == nil then var1.NextSelectionRight else var7[dot3.page],
            ref = var7[dot.page],
            testId = `{var1.testId}--page-{dot.page}`
        })
    end

    local layout = React.useMemo(function()
        return {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, size100),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }
    end, { size100 })

    return React.createElement(View, withCommonProps(var1, { tag = "auto-xy" }), {
        Dots = React.createElement(View, {
            tag = "auto-y",
            Size = UDim2.fromOffset(xOffset, 0),
            layout = layout,
            Position = var5:map(function(xOffset2: number): UDim2
                return UDim2.fromOffset(xOffset2, 0)
            end),
            testId = `{var1.testId}--dots`
        }, tbl2)
    })
end))
