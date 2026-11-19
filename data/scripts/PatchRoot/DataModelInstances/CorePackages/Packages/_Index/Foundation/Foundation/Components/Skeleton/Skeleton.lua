-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local useClock = require(FoundationParent.ReactUtils).useClock

local Components = Foundation.Components
local _Types = require(Components.Types)
local View = require(Components.View)

local Radius = require(Foundation.Enums.Radius)

local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local usePulseBinding = require(Foundation.Utility.usePulseBinding)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local lerp = require(Foundation.Utility.lerp)

local tbl1 = {
    radius = Radius.None,
    Size = UDim2.fromScale(1, 1),
    testId = "--foundation-skeleton"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Skeleton
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useClock()
    local var3 = usePulseBinding(2)
    local var4 = useTokens()
    local var5 = usePreferences()
    local cornerRadius = if var1.radius == Radius.None then nil else UDim.new(0, var4.Radius[var1.radius])
    local shimmer = var4.Color.Common.Shimmer

    local createElement = React.createElement
    local var7 = View
    local var8 = withCommonProps

    local tbl2 = {
        cornerRadius = cornerRadius,
        backgroundStyle = if var5.reducedMotion then var3:map(function(num1: number)
            local shimmerTransparency = shimmer.Transparency
            return {
                Color3 = shimmer.Color3,
                Transparency = lerp(shimmerTransparency, shimmerTransparency - 0.1, num1)
            }
        end) else var4.Color.Extended.White.White_100,
        Size = var1.Size,
        ref = ref
    }

    local var9 = var8(var1, tbl2)

    local tbl3 = { Gradient = 0 }
    local element

    if var5.reducedMotion then
        element = nil
    else
        element = React.createElement("UIGradient", {
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, shimmer.Color3), ColorSequenceKeypoint.new(0.5, var4.Color.Extended.White.White_30.Color3), ColorSequenceKeypoint.new(1, shimmer.Color3) }),
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, shimmer.Transparency), NumberSequenceKeypoint.new(0.5, var4.Color.Extended.White.White_30.Transparency), NumberSequenceKeypoint.new(1, shimmer.Transparency) }),
            Offset = var2:map(function(num1: number): Vector2
                return Vector2.new(num1 * 2 % 3 - 1.5, 0)
            end),
            Rotation = 15
        })
    end

    tbl3.Gradient = element
    return createElement(var7, var9, tbl3)
end))
