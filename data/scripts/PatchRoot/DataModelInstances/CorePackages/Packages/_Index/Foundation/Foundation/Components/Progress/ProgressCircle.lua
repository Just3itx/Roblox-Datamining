-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:40:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local constants = require(script.Parent.constants)
local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local mapBindable = require(Foundation.Utility.mapBindable)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local useProgressBinding = require(script.Parent.useProgressBinding)
local useProgressVariants = require(script.Parent.useProgressVariants)
local usePulseBinding = require(Foundation.Utility.usePulseBinding)
local useRotation = require(Foundation.Utility.useRotation)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _ProgressShape = require(Foundation.Enums.ProgressShape)

local tbl1 = {
    size = require(Foundation.Enums.ProgressSize).Medium
}

local function getRotationFromProgress(num1: number?, horizontalAlignment): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = if horizontalAlignment == Enum.HorizontalAlignment.Left then 180 else 0
    local num3 = if horizontalAlignment == Enum.HorizontalAlignment.Left then 360 else 180
    if num1 == nil then
        return 0
    end

    return math.clamp(num1 * 360, num2, num3)
end

local function getLabelFromProgress(num1: number?): string
    if num1 == nil then
        return "0%"
    end

    local num2 = num1 * 100
    return `{math.floor(num2)}%`
end

local function getCapAngleFromProgress(num1: number?): number
    return math.clamp(num1 or 0, 0, 1) * 360
end

local function hasVisibleArc(num1: number?): boolean
    return (num1 or 0) > 0
end

local function ArcCap(tbl2)
    local var1 = useTokens()

    return React.createElement(
        View,
        {
            Size = UDim2.fromScale(1, 1),
            Rotation = tbl2.angle,
            Visible = tbl2.isVisible,
            ZIndex = 2,
            testId = tbl2.testId
        },
        {
            Cap = React.createElement(View, {
                Position = UDim2.fromScale(0.5, 5 / 116),
                Size = UDim2.fromScale(5 / 58, 5 / 58),
                backgroundStyle = var1.Color.Content.Emphasis,
                tag = "anchor-center-center radius-circle",
                ZIndex = 2
            })
        }
    )
end

local function ArcCaps(tbl2)
    local isVisible = mapBindable(tbl2.progress, hasVisibleArc)

    return React.createElement(React.Fragment, {}, {
        StartCap = React.createElement(ArcCap, { angle = 0, isVisible = isVisible, testId = `{tbl2.testId}--start-cap` }),
        EndCap = React.createElement(ArcCap, {
            angle = mapBindable(tbl2.progress, getCapAngleFromProgress),
            isVisible = isVisible,
            testId = `{tbl2.testId}--end-cap`
        })
    })
end

local function ProgressGradient(tbl2)
    local side = tbl2.side
    local isIndeterminate = tbl2.isIndeterminate
    local progress = tbl2.progress
    local pulse = tbl2.pulse

    local var1 = useTokens()
    local var2 = usePreferences()

    local var3 = React.useMemo(function(): NumberSequence
        local emphasisTransparency = var1.Color.Content.Emphasis.Transparency
        local var3 = if isIndeterminate then 1 else var1.Color.Shift.Shift_200.Transparency

        return NumberSequence.new({
            NumberSequenceKeypoint.new(0, emphasisTransparency),
            NumberSequenceKeypoint.new(0.4999, emphasisTransparency),
            NumberSequenceKeypoint.new(0.5, var3),
            NumberSequenceKeypoint.new(1, var3)
        })
    end, { var1, isIndeterminate })

    local var4 = React.useMemo(function(): ColorSequence
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0, var1.Color.Content.Emphasis.Color3),
            ColorSequenceKeypoint.new(0.4999, var1.Color.Content.Emphasis.Color3),
            ColorSequenceKeypoint.new(0.5, var1.Color.Shift.Shift_200.Color3),
            ColorSequenceKeypoint.new(1, var1.Color.Shift.Shift_200.Color3)
        })
    end, { var1 })

    if isIndeterminate and var2.reducedMotion and pulse then
        return React.createElement("UIGradient", {
            Transparency = pulse:map(function(num1: number)
                return NumberSequence.new(math.lerp(var1.Color.Content.Emphasis.Transparency, var1.Color.Shift.Shift_200.Transparency, num1))
            end),
            Color = pulse:map(function(num1: number)
                return ColorSequence.new(var1.Color.Content.Emphasis.Color3:Lerp(var1.Color.Shift.Shift_200.Color3, num1))
            end),
            Rotation = if side == Enum.HorizontalAlignment.Left then 0 else 180
        })
    end
    return (React.createElement("UIGradient", {
        Transparency = var3,
        Color = var4,
        Rotation = mapBindable(progress, function(num1: number?): number
            return getRotationFromProgress(num1, side)
        end)
    }))
end

local function ProgressRing(tbl2)
    return React.createElement(React.Fragment, {}, {
        LeftGradient = React.createElement(
            View,
            {
                Size = UDim2.fromScale(0.5, 1),
                tag = "position-top-left clip",
                testId = `{tbl2.testId}--left-gradient`
            },
            {
                Image = React.createElement(Image, {
                    Image = "rbxasset://textures/ui/Controls/RadialFill.png",
                    Size = UDim2.fromScale(2, 1),
                    tag = "position-top-left content-emphasis"
                }, {
                    Gradient = React.createElement(ProgressGradient, {
                        side = Enum.HorizontalAlignment.Left,
                        isIndeterminate = tbl2.isIndeterminate,
                        progress = tbl2.progress,
                        pulse = tbl2.pulse
                    })
                })
            }
        ),
        RightGradient = React.createElement(View, {
            Size = UDim2.fromScale(0.5, 1),
            tag = "position-top-center clip",
            testId = `{tbl2.testId}--right-gradient`
        }, {
            Image = React.createElement(Image, {
                Image = "rbxasset://textures/ui/Controls/RadialFill.png",
                Size = UDim2.fromScale(2, 1),
                Position = UDim2.fromScale(-1, 0),
                tag = "content-emphasis"
            }, {
                Gradient = React.createElement(ProgressGradient, {
                    side = Enum.HorizontalAlignment.Right,
                    isIndeterminate = tbl2.isIndeterminate,
                    progress = tbl2.progress,
                    pulse = tbl2.pulse
                })
            })
        }),
        Caps = if tbl2.hasCaps then React.createElement(ArcCaps, { progress = tbl2.progress, testId = tbl2.testId }) else nil
    })
end

local function SpinningRing(tbl2)
    return React.createElement(
        View,
        {
            Size = tbl2.size,
            Rotation = tbl2.rotation,
            testId = `{tbl2.testId}--indeterminate-container`
        },
        {
            Ring = React.createElement(
                ProgressRing,
                {
                    progress = 0.8,
                    isIndeterminate = true,
                    hasCaps = tbl2.hasCaps,
                    testId = tbl2.testId
                }
            )
        }
    )
end

local function ProgressCircle(arg1)
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = usePreferences()
    local var4 = useProgressVariants(var2, var1.size)
    local progress, isIndeterminate = useProgressBinding(var1.value)
    local rotation = useRotation(1)
    local pulse = usePulseBinding(1 / constants.INDETERMINATE_SHIMMER_SPEED)

    local uDim2 = UDim2.fromOffset(var4.circle.size, var4.circle.size)

    if isIndeterminate and not var3.reducedMotion then
        return React.createElement(View, withCommonProps(var1, { tag = "auto-xy", ref = var1.ref }), {
            IndeterminateContainer = React.createElement(SpinningRing, { size = uDim2, rotation = rotation, hasCaps = true, testId = var1.testId })
        })
    end

    return React.createElement(View, withCommonProps(var1, { Size = uDim2, ref = var1.ref }), {
        Ring = React.createElement(ProgressRing, {
            progress = progress,
            isIndeterminate = isIndeterminate,
            pulse = pulse,
            hasCaps = not isIndeterminate,
            testId = var1.testId
        }),
        ProgressLabel = if var4.circle.labelFont and not isIndeterminate then React.createElement(Text, {
            Text = mapBindable(progress, getLabelFromProgress),
            fontStyle = var4.circle.labelFont,
            tag = "position-center-center anchor-center-center",
            testId = `{var1.testId}--label`
        }) else nil
    })
end

return ProgressCircle
