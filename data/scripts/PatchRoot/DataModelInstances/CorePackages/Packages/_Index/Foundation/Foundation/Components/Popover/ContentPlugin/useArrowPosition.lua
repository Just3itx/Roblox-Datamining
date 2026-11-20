-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local Flags = require(Foundation.Utility.Flags)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local Radius = require(Foundation.Enums.Radius)
local useTokens = require(Foundation.Providers.Style.useTokens)
local var1 = if Flags.FoundationPluginShadowSize then Constants.PLUGIN_SHADOW_SIZE else Constants.SHADOW_SIZE

local function useArrowPosition(arg1, arg2, arg3, num1: number, num2: number, arg4)
    local var2 = useTokens()
    local var3 = React.useMemo(function()
        if arg3 == Radius.XSmall then
            return var2.Size.Size_50
        end

        if arg3 == Radius.Small then
            return var2.Size.Size_100
        end

        if arg3 == Radius.Medium then
            return var2.Size.Size_200
        end

        if arg3 == Radius.Large then
            return var2.Size.Size_300
        end

        return 0
    end, { arg3, var2 })

    return arg1:map(function(uDim2: UDim2): UDim2
        local offset = uDim2.X.Offset
        local offset2 = uDim2.Y.Offset

        local var4 = var3
        if arg3 == Radius.Circle then
            var4 = math.min(offset, offset2) / 2
        end

        local var5 = var4 + num2
        local bool1 = arg2 == PopoverSide.Top or arg2 == PopoverSide.Bottom
        local var6 = if bool1 then offset else offset2
        local var7

        if arg4 and typeof(arg4) == "Instance" then
            local absoluteSize = arg4.AbsoluteSize
            local var8 = if bool1 then absoluteSize.X else absoluteSize.Y
            local var9 = if num1 == 0 then 0 elseif num1 == 0.5 then (var6 - var8) / 2 else var6 - var8
            local num3 = math.max(0, var9)
            local num4 = math.min(var6, var9 + var8)

            if num3 <= num4 then
                var7 = (num3 + num4) / 2
            elseif var6 < var9 then
                var7 = var6 - num2
            else
                var7 = num2
            end
        else
            var7 = var6 * num1
        end

        local var8 = var6 - var5
        local var9 = if var5 <= var8 then math.clamp(var7, var5, var8) else var6 / 2

        if bool1 then
            return UDim2.fromOffset(var1 + var9, var1 + (if arg2 ~= PopoverSide.Top then 0 else offset2))
        end

        return UDim2.fromOffset(var1 + (if arg2 ~= PopoverSide.Left then 0 else offset), var1 + var9)
    end)
end

return useArrowPosition
