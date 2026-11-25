-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent
local React = require(RobloxAppHooksParent.React)
local ReactOtter = require(RobloxAppHooksParent.ReactOtter)

local tbl1 = { dampingRatio = 1, frequency = 3 }

local function calculateTargetScrollOffset(arg1, arg2, scrollingDirection: number, num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local var1

    if scrollingDirection == Enum.ScrollingDirection.X then
        var1 = arg1.CanvasPosition.X + (arg2.AbsolutePosition.X - arg1.AbsolutePosition.X)
    else
        var1 = arg1.CanvasPosition.Y + (arg2.AbsolutePosition.Y - arg1.AbsolutePosition.Y)
    end
    if var1 < num2 then
        return 0
    end

    return math.max(var1 - num1, 0)
end

local function useAnimatedScrollToSelection(scrollingDirection: number, num1: number?, num2: number?, arg1)
    local num3 = num1 or 0
    local num4 = num2 or 0
    local var1 = arg1 or tbl1

    local var2, var3 = ReactOtter.useAnimatedBinding(0)

    local var4 = React.useCallback(function(arg2, bool1: boolean, _, arg3)
        if bool1 then
            return
        end
        if arg3 and arg3:IsDescendantOf(arg2) then
            local targetScrollOffset = calculateTargetScrollOffset(arg2, arg3, scrollingDirection, num3, num4)

            var3(ReactOtter.spring(targetScrollOffset, var1))
        end
    end, {
        num3,
        scrollingDirection,
        num4,
        var1
    })

    return React.useMemo(function()
        return var2:map(function(num5: number): Vector2
            if scrollingDirection == Enum.ScrollingDirection.X then
                return Vector2.new(num5, 0)
            end

            return Vector2.new(0, num5)
        end)
    end, { scrollingDirection }), var4
end

return useAnimatedScrollToSelection
