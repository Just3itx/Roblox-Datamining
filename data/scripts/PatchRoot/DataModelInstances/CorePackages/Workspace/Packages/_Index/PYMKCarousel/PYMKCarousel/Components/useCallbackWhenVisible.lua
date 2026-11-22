-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarouselParent = script:FindFirstAncestor("PYMKCarousel").Parent

local React = require(PYMKCarouselParent.React)
local useSelector = require(PYMKCarouselParent.RoactUtils).Hooks.RoactRodux.useSelector
local useNavigationFocus = require(PYMKCarouselParent.Navigation).useNavigationFocus
local FFlagEnableOnScreenAPIIntegration = require(PYMKCarouselParent.SharedFlags).FFlagEnableOnScreenAPIIntegration
local useIsRouteOnScreen = if FFlagEnableOnScreenAPIIntegration then require(PYMKCarouselParent.RobloxAppNavigation).useIsRouteOnScreen else nil
local num1 = game:DefineFastInt("HomePagePYMKPercentageOfViewPortToStartFetch", 25)

local function func1()
    local var1 = useSelector(function(arg1)
        return arg1.ScreenSize
    end)
    local y = useSelector(function(arg1)
        return arg1.TopBar.topBarHeight
    end)
    local var2 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)
    return (React.useMemo(function()
        return {
            min = Vector2.new(0, y),
            max = Vector2.new(var1.X, var1.Y - var2.bottom)
        }
    end, { y, var1, var2 }))
end

local function func2(tbl1, elementRef): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local current = elementRef and elementRef.current

    if not current then
        return false
    end

    local absolutePositionY = current.AbsolutePosition.Y
    local var1 = current.AbsolutePosition.Y + current.AbsoluteSize.Y

    local minY = tbl1.min.Y
    local maxY = tbl1.max.Y
    local var2 = (maxY - minY) / 100 * num1

    return minY - var2 < absolutePositionY and var1 < maxY + var2
end

return function(tbl1)
    local elementRef = tbl1.elementRef
    local scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal
    local callback = tbl1.callback
    local var1 = if FFlagEnableOnScreenAPIIntegration then useIsRouteOnScreen() else useNavigationFocus()
    local var2 = func1()

    React.useEffect(function()
        if func2(var2, elementRef) and var1 then
            callback()
        end

        if not scrollViewPositionChangedSignal then
            return
        end

        scrollViewPositionChangedSignal:connect(function()
            if func2(var2, elementRef) and var1 then
                callback()
            end
        end)
    end, {
        elementRef,
        scrollViewPositionChangedSignal,
        var1,
        var2
    })
end
