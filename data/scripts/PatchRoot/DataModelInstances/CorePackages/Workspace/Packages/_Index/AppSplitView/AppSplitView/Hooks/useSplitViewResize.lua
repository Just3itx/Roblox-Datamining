-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:30:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppSplitView = script:FindFirstAncestor("AppSplitView")
local AppSplitViewParent = AppSplitView.Parent

local React = require(AppSplitViewParent.React)

local Enums = require(AppSplitView.Common.Enums)

local function toSupportSize(xOffset: number): UDim2
    return UDim2.new(0, xOffset, 1, 0)
end

local function useSplitViewResize(current)
    local navWidth = current.navWidth
    local supportWidth = current.supportWidth
    local bool1 = (current.variant or Enums.SplitVariant.SplitRight) == Enums.SplitVariant.SplitRight

    local var1, var2 = React.useState(current.hasWidthOverride == true)

    local var3, var4 = React.useBinding(supportWidth)
    local var5, var6 = React.useBinding(supportWidth)
    local var7 = React.useRef(supportWidth)
    local var8 = React.useRef(current)
    var8.current = current

    React.useEffect(function()
        if current.hasWidthOverride then
            var2(true)
        end
    end, { current.hasWidthOverride })

    React.useEffect(function()
        var4(supportWidth)
        if supportWidth == 0 then
            var7.current = 0
            var6(0)
        end
    end, { supportWidth })

    local onSupportAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        var7.current = absoluteSizeX
        var6(absoluteSizeX)
    end, {})

    local onResizerDrag = React.useCallback(function(vector2: Vector2)
        var2(true)
        local num1 = if (var8.current.variant or Enums.SplitVariant.SplitRight) == Enums.SplitVariant.SplitRight then -1 else 1
        var4(var7.current + num1 * vector2.X)
    end, {})

    local onResizerDragEnd = React.useCallback(function()
        local current2 = var8.current
        if current2.onSupportPaneWidthChanged then
            current2.onSupportPaneWidthChanged(var7.current)
        end
    end, {})

    local var12 = React.useCallback(function(num1: number): UDim2
        return UDim2.new(0, navWidth + num1, 0, 0)
    end, { navWidth })

    local var13 = React.useCallback(function(num1: number): UDim2
        return UDim2.new(1, -(navWidth + num1), 1, 0)
    end, { navWidth })

    local var14 = React.useCallback(function(num1: number): UDim2
        local xOffset = if bool1 then -num1 - 12 else navWidth + num1 - 12

        if bool1 then
            return UDim2.new(1, xOffset, 0, 0)
        end

        return UDim2.new(0, xOffset, 0, 0)
    end, { navWidth, bool1 })

    local var15 = React.useCallback(function(num1: number): UDim2
        return UDim2.new(1, -num1, 0, 0)
    end, {})

    local contentPosition = React.useMemo(function()
        if bool1 then
            return UDim2.new(0, navWidth, 0, 0)
        end

        return (var5:map(var12))
    end, { bool1, navWidth, var12 })

    local contentSize = React.useMemo(function()
        return var5:map(var13)
    end, { var13 })

    local supportPosition = React.useMemo(function()
        if bool1 then
            return (var5:map(var15))
        end

        return UDim2.new(0, navWidth, 0, 0)
    end, { bool1, navWidth, var15 })

    local var19 = React.useMemo(function()
        return var3:map(toSupportSize)
    end, {})
    if not var1 then
        var19 = nil
    end
    return {
        contentPosition = contentPosition,
        contentSize = contentSize,
        supportPosition = supportPosition,
        supportSize = var19,
        resizerPosition = React.useMemo(function()
            return var5:map(var14)
        end, { var14 }),
        resizerHitWidth = 24,
        onSupportAbsoluteSizeChanged = onSupportAbsoluteSizeChanged,
        onResizerDrag = onResizerDrag,
        onResizerDragEnd = onResizerDragEnd
    }
end

return useSplitViewResize
