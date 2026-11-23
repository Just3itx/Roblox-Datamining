-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewportUtilsParent = script:FindFirstAncestor("ViewportUtils").Parent
local Display = require(ViewportUtilsParent.Display)
local React = require(ViewportUtilsParent.React)
local Signals = require(ViewportUtilsParent.Signals)
local SignalsReact = require(ViewportUtilsParent.SignalsReact)
local SharedFlags = require(ViewportUtilsParent.SharedFlags)

local intersectBounds = require(script.Parent.intersectBounds)
local useClipAncestorBounds = require(script.Parent.useClipAncestorBounds)

local bool1 = game:DefineFastFlag("LuaAppFixFrameBoundsImpressions", false)

local FIntLuaAppUpdateImpressionsViewportBoundsPositionThreshold = SharedFlags.FIntLuaAppUpdateImpressionsViewportBoundsPositionThreshold
local bool2 = game:DefineFastFlag("LuaAppThrottleViewportBoundsScreenSize", false)
local FIntLuaAppViewportBoundsScreenSizeThreshold = SharedFlags.FIntLuaAppViewportBoundsScreenSizeThreshold

local FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions = SharedFlags.FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions
local FFlagLuaAppRespectClipAncestorImpressions = SharedFlags.FFlagLuaAppRespectClipAncestorImpressions
local bool3 = game:DefineFastFlag("LuaAppUseViewportBoundsInsetFix", false)
local FFlagUnifyShortcutBarFixImpressions = SharedFlags.FFlagUnifyShortcutBarFixImpressions

local function boundsEqual(tbl1, tbl2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.min == tbl2.min and tbl1.max == tbl2.max
end

local function screenSizeBoundsEqual(tbl1, tbl2): boolean
    local var1 = FIntLuaAppViewportBoundsScreenSizeThreshold
    local var2 = tbl1.max.X - tbl2.max.X

    if math.abs(var2) < var1 and math.abs(tbl1.max.Y - tbl2.max.Y) < var1 and tbl1.min.X == tbl2.min.X then
        return tbl1.min.Y == tbl2.min.Y
    end

    return false
end

local tbl1 = {
    min = Vector2.zero,
    max = Vector2.zero
}
local function calculateClampedViewportBounds(vector2: Vector2?, vector2_2: Vector2?, tbl2)
    local var1 = vector2 or Vector2.zero
    local var2 = var1 + (vector2_2 or Vector2.zero)

    local x = math.max(tbl2.min.X, var1.X)
    local x2 = math.min(tbl2.max.X, var2.X)
    local y = math.max(tbl2.min.Y, var1.Y)
    local y2 = math.min(tbl2.max.Y, var2.Y)

    if bool1 and (x2 <= x or y2 <= y) then
        return tbl1
    end

    return {
        min = Vector2.new(x, y),
        max = Vector2.new(x2, y2)
    }
end

return function(tbl2, bool4: boolean?, bool5: boolean?, num1: number?)
    local var1 = FFlagUnifyShortcutBarFixImpressions and (num1 or 0) or nil
    local var2

    if bool2 then
        local useMemo = React.useMemo

        local function func1()
            return Signals.createComputed(function(arg1)
                local displayStore = Display.GetDisplayStore(arg1)
                local viewportSize = displayStore.getViewportSize(arg1)
                local topBarHeight = displayStore.getTopBarHeight(arg1)
                local guiInset = if bool3 then nil else displayStore.getGuiInset(arg1)
                return {
                    min = Vector2.new(0, topBarHeight),
                    max = Vector2.new(viewportSize.X, if bool3 or bool4 then viewportSize.Y else viewportSize.Y - guiInset.bottom) - (if FFlagUnifyShortcutBarFixImpressions then Vector2.new(0, var1) else Vector2.zero)
                }
            end, screenSizeBoundsEqual)
        end

        local var3 = if FFlagUnifyShortcutBarFixImpressions then var1 else nil
        local var4 = useMemo(func1, { bool4, var3 })

        var2 = SignalsReact.useSignalState(var4)
    else
        local var3 = SignalsReact.useSignalState(function(arg1)
            return Display.GetDisplayStore(arg1).getViewportSize(arg1)
        end)
        local y = SignalsReact.useSignalState(function(arg1)
            return Display.GetDisplayStore(arg1).getTopBarHeight(arg1)
        end)

        local var4 = if bool3 then nil else SignalsReact.useSignalState(function(arg1)
            return Display.GetDisplayStore(arg1).getGuiInset(arg1)
        end)

        local useMemo = React.useMemo
        local function func1()
            return {
                min = Vector2.new(0, y),
                max = Vector2.new(var3.X, if bool3 or bool4 then var3.Y else var3.Y - var4.bottom) - (if FFlagUnifyShortcutBarFixImpressions then Vector2.new(0, var1) else Vector2.zero)
            }
        end

        local var5 = if bool3 then nil else var4
        local var6 = if FFlagUnifyShortcutBarFixImpressions then var1 else nil
        var2 = useMemo(func1, { y, var3, var5, bool4, var6 })
    end

    local var3 = if FFlagLuaAppRespectClipAncestorImpressions then useClipAncestorBounds(if bool5 then tbl2 else nil) else nil
    local var4, var5 = React.useState(tbl1)

    local var6 = if bool1 then React.useCallback(function(tbl3)
        var5(function(tbl4)
            return if boundsEqual(tbl4, tbl3) then tbl4 else tbl3
        end)
    end, {}) else var5

    local useEffect = React.useEffect
    local function func1()
        local tbl3 = {}
        local current = if tbl2 then tbl2.current else nil

        if current then
            local absolutePosition = current.AbsolutePosition
            local absoluteSize = current.AbsoluteSize
            local var7 = if bool1 then absolutePosition else nil
            local var8 = if bool2 then absoluteSize else nil
            var6(
                if FFlagLuaAppRespectClipAncestorImpressions then intersectBounds({ min = absolutePosition, max = absolutePosition + absoluteSize }, var2) else calculateClampedViewportBounds(absolutePosition, absoluteSize, var2)
            )

            local absolutePositionChanged = current:GetPropertyChangedSignal("AbsolutePosition")

            table.insert(tbl3, absolutePositionChanged:Connect(function()
                absolutePosition = current.AbsolutePosition

                if bool1 then
                    local var9 = FIntLuaAppUpdateImpressionsViewportBoundsPositionThreshold
                    local var10 = absolutePosition - var7
                    if math.abs(var10.X) < var9 and math.abs(var10.Y) < var9 then
                        return
                    end
                    var7 = absolutePosition
                end

                var6(
                    if FFlagLuaAppRespectClipAncestorImpressions then intersectBounds({ min = absolutePosition, max = absolutePosition + absoluteSize }, var2) else calculateClampedViewportBounds(absolutePosition, absoluteSize, var2)
                )
            end))

            local absoluteSizeChanged = current:GetPropertyChangedSignal("AbsoluteSize")

            table.insert(tbl3, absoluteSizeChanged:Connect(function()
                absoluteSize = current.AbsoluteSize

                if bool2 then
                    local var9 = FIntLuaAppViewportBoundsScreenSizeThreshold
                    local var10 = absoluteSize - var8
                    if math.abs(var10.X) < var9 and math.abs(var10.Y) < var9 then
                        return
                    end
                    var8 = absoluteSize
                end

                var6(
                    if FFlagLuaAppRespectClipAncestorImpressions then intersectBounds({ min = absolutePosition, max = absolutePosition + absoluteSize }, var2) else calculateClampedViewportBounds(absolutePosition, absoluteSize, var2)
                )
            end))
        else
            var6(var2)
        end

        return function()
            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    end

    local var7 = var2
    local var8 = if FFlagLuaAppRespectClipAncestorImpressions then var6 else nil
    useEffect(func1, { tbl2, var7, var8 })

    local var9 = if FFlagLuaAppRespectClipAncestorImpressions then React.useMemo(function()
        if var3 then
            return (intersectBounds(var4, var3))
        end

        return var4
    end, { var4, var3 }) else var4

    if not FFlagLuaAppRespectClipAncestorImpressions then
        var9 = var4
    end

    return var9, if FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions then var2 else nil
end
