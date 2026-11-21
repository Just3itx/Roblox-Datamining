-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent

local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)

local View = Foundation.View
local Radius = Foundation.Enums.Radius
local usePulseBinding = Foundation.Hooks.usePulseBinding
local useTokens = Foundation.Hooks.useTokens
local withCommonProps = Foundation.Utility.withCommonProps
local withDefaults = Foundation.Utility.withDefaults

local function lerp(transparency: number, num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return (1 - num2) * transparency + num1 * num2
end

local tbl1 = {
    radius = Radius.None,
    Size = UDim2.fromScale(1, 1),
    testId = "--foundation-skeleton"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: ItemCardThumbnailSkeleton
    local var1 = withDefaults(arg1, tbl1)
    local var2 = usePulseBinding(2)
    local var3 = useTokens()
    local cornerRadius = if var1.radius == Radius.None then nil else UDim.new(0, var3.Radius[var1.radius])

    return React.createElement(
        View,
        withCommonProps(var1, {
            cornerRadius = cornerRadius,
            backgroundStyle = var2:map(function(num1: number)
                return {
                    Color3 = var3.Color.Shift.Shift_300.Color3,
                    Transparency = lerp(var3.Color.Extended.White.White_10.Transparency, var3.Color.Extended.White.White_10.Transparency - 0.1, num1)
                }
            end),
            Size = var1.Size,
            ref = ref
        })
    )
end))
