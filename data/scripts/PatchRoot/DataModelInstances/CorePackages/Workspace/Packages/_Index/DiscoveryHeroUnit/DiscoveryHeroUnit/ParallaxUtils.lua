-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryHeroUnitParent = script:FindFirstAncestor("DiscoveryHeroUnit").Parent
local React = require(DiscoveryHeroUnitParent.React)

local function customEasing(num1: number, num2: number, num3: number, num4: number, num5: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return (1 - num1) ^ 3 * num2 + 3 * (1 - num1) ^ 2 * num1 * num3 + 3 * (1 - num1) * num1 ^ 2 * num4 + num1 ^ 3 * num5
end

return {
    useNormalizedVerticalProgress = function(tbl1, tbl2)
        local var1, var2 = React.useBinding(-1)

        React.useEffect(function()
            local tbl3 = {}
            if tbl1 and tbl1.current and tbl2.current then
                local current = tbl2.current
                local current2 = tbl1.current

                local absolutePositionY = current2.AbsolutePosition.Y
                local absoluteWindowSizeY = current2.AbsoluteWindowSize.Y

                local function calculateOffset() -- Luacid: Inlined by compiler; 3 call sites recovered
                    return current.AbsolutePosition.Y + current2.CanvasPosition.Y - absolutePositionY
                end

                local var3 = calculateOffset()

                local function updateBinding() -- Luacid: Inlined by compiler; 1 call site recovered
                    if absoluteWindowSizeY == 0 then
                        return
                    end
                    local var4 = (var3 - current2.CanvasPosition.Y) / absoluteWindowSizeY
                    var2(var4)
                end

                local function updateWindowParams()
                    absolutePositionY = current2.AbsolutePosition.Y
                    absoluteWindowSizeY = current2.AbsoluteWindowSize.Y
                    var3 = calculateOffset()
                    updateBinding()
                end

                absolutePositionY = current2.AbsolutePosition.Y
                absoluteWindowSizeY = current2.AbsoluteWindowSize.Y
                var3 = calculateOffset()

                if absoluteWindowSizeY ~= 0 then
                    local canvasPositionY = current2.CanvasPosition.Y
                    local var4 = (var3 - canvasPositionY) / absoluteWindowSizeY
                    var2(var4)
                end

                tbl3 = {
                    current2:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateWindowParams),
                    current2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateWindowParams),
                    current2:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateWindowParams),
                    current2:GetPropertyChangedSignal("CanvasPosition"):Connect(updateBinding)
                }
            end
            return function()
                for _, value in tbl3 do
                    value:Disconnect()
                end
            end
        end, { tbl2, tbl1 })

        return var1
    end,
    getYPositionOffsetForMotion = function(num1: number, num2: number, num3: number, num4: number)
        local num5 = math.clamp(num1, -1, 1)
        if num5 >= 0 then
            local num6 = customEasing(num5, 0, 0.3, 0.6, 1)
            return num3 * num6 + num4 * (1 - num6)
        end
        local num6 = customEasing(-num5, 0, 0.3, 0.6, 1)
        return num2 * num6 + num4 * (1 - num6)
    end,
    getNormalizedTopPosition = function(arg1, arg2)
        if not (arg2 and arg1) then
            return nil
        end

        local absolutePositionY = arg1.AbsolutePosition.Y
        local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
        local var1 = arg2.AbsolutePosition.Y + arg1.CanvasPosition.Y - absolutePositionY - arg1.CanvasPosition.Y
        return if absoluteWindowSizeY == 0 then nil else var1 / absoluteWindowSizeY
    end
}
