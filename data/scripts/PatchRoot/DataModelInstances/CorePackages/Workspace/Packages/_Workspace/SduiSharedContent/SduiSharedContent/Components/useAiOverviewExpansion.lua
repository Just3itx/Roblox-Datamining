-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local ReactOtter = require(SduiSharedContentParent.ReactOtter)

local tbl1 = { dampingRatio = 0.9, frequency = 6 }

local function useAiOverviewExpansion(tbl2)
    local var1 = if tbl2.hasHeader and tbl2.hasExpandableBody then tbl2.sectionGap else 0
    local var2, var3 = React.useState(false)
    local var4, var5 = React.useState(false)
    local var6 = React.useRef(false)

    local var7, var8 = React.useState(nil)
    local var9, var10 = React.useState(nil)
    local onHeaderAbsoluteSizeChanged = React.useCallback(function(arg1)
        var10(arg1.AbsoluteSize.Y)
    end, {})
    local onContentAbsoluteSizeChanged = React.useCallback(function(arg1)
        var8(arg1.AbsoluteSize.Y)
    end, {})

    local compactHeight = tbl2.compactHeight
    local buttonHeight = tbl2.buttonHeight
    local bool1 = not (compactHeight == nil) and compactHeight > 0
    local var13 = if bool1 then compactHeight else 0
    local var14 = var7 or 0
    local var15 = if tbl2.hasHeader then (var9 or 0) + var1 else 0
    local var16 = buttonHeight + tbl2.sectionGap
    local bool2 = not bool1 or not tbl2.hasHeader or var9 ~= nil
    local bool3 = not bool1 or not tbl2.hasExpandableBody or var7 ~= nil
    local var17 = if bool1 then math.max(0, var13 - var15 - var16) else 0
    local bool4 = bool1 and bool2 and bool3 and var17 > 0 and var17 + 1 < var14
    local var18 = bool1 and tbl2.hasExpandableBody and not (var2 or bool2 and bool3)

    local isCompact = bool4 and not var2
    local var19 = bool4 and var2 and not var4
    local useCompactViewport = var18 or isCompact or var19
    local shouldReserveCompactHeight = var18 or isCompact
    local reducedMotion = tbl2.reducedMotion
    local var22 = if var2 then var14 elseif useCompactViewport then var17 else 0

    local var23 = React.useCallback(function()
        if var6.current then
            var6.current = false
            var5(true)
        end
    end, {})

    local animatedViewportHeight, var25 = ReactOtter.useAnimatedBinding(var22, var23)

    local onExpand = React.useCallback(function()
        var3(true)

        if not bool4 then
            return
        end

        if reducedMotion then
            var6.current = false
            var5(true)
            var25((ReactOtter.instant(var14)))
        else
            var6.current = true
            var5(false)
            var25((ReactOtter.spring(var14, tbl1)))
        end
    end, {
        var14,
        bool4,
        reducedMotion,
        var25
    })
    React.useLayoutEffect(function()
        if var19 then
            return
        end

        var6.current = false
        var25((ReactOtter.instant(var22)))
    end, { var22, var19, var25 })

    return {
        isCompact = isCompact,
        shouldReserveCompactHeight = shouldReserveCompactHeight,
        useCompactViewport = useCompactViewport,
        animatedViewportHeight = animatedViewportHeight,
        onExpand = onExpand,
        onHeaderAbsoluteSizeChanged = onHeaderAbsoluteSizeChanged,
        onContentAbsoluteSizeChanged = onContentAbsoluteSizeChanged
    }
end

return useAiOverviewExpansion
