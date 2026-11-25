-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local ReactOtter = require(scriptParentParentParent.ReactOtter)

local function springOptions(tbl1, startingValue: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        dampingRatio = tbl1.dampingRatio,
        frequency = tbl1.frequency,
        startingValue = startingValue
    }
end

return {
    useSlideOpenCloseAnimation = function(current: boolean, tbl1, bool2: boolean)
        local shouldMount, var2 = React.useState(current)
        local var3 = React.useRef(current)
        var3.current = current
        local var4 = React.useRef(true)

        if current and not shouldMount then
            var2(true)
        end

        local var5 = React.useCallback(function()
            if not var3.current then
                var2(false)
            end
        end, {})

        local offset, var7 = ReactOtter.useAnimatedBinding(if current then 0 else tbl1.hiddenOffset, var5)

        local position = React.useMemo(function()
            return offset:map(function(xScale: number): UDim2
                return UDim2.new(xScale, 0, 0, 0)
            end)
        end, { offset })

        React.useEffect(function()
            local current2 = var4.current
            var4.current = false

            if current then
                var2(true)
                if current2 and not tbl1.animateInitialOpen then
                    return
                end
                var7(ReactOtter.spring(0, (springOptions(tbl1, tbl1.openStartOffset))))
            elseif not current2 then
                var7(ReactOtter.spring(tbl1.hiddenOffset, (springOptions(tbl1, nil))))
            end
        end, { current, bool2, tbl1 })

        return { offset = offset, position = position, shouldMount = shouldMount }
    end,
    PANEL_SLIDE_CONFIG = {
        hiddenOffset = 1.1,
        openStartOffset = 0.2,
        dampingRatio = 1,
        frequency = 7,
        animateInitialOpen = false
    },
    PANEL_ZOOM_CONFIG = {
        hiddenOffset = 1,
        openStartOffset = 1,
        dampingRatio = 1,
        frequency = 4,
        animateInitialOpen = false
    },
    MENU_SLIDE_CONFIG = {
        hiddenOffset = 1,
        openStartOffset = 1,
        dampingRatio = 1,
        frequency = 4,
        animateInitialOpen = true
    },
    MOBILE_ZOOM_SPRING = { dampingRatio = 1, frequency = 4 },
    MENU_ZOOM_CLOSED_SCALE = 1.25,
    PANEL_RECESS_SCALE = 0.95,
    PANEL_RECESS_TRANSPARENCY = 0.6
}
