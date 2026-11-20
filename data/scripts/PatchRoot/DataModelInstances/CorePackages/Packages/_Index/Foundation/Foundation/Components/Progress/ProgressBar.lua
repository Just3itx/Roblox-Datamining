-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local constants = require(script.Parent.constants)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getTestIdTag = require(Foundation.Utility.getTestIdTag)
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

local ProgressSize = require(Foundation.Enums.ProgressSize)

local function getFillSizeFromProgress(num1: number?): UDim2
    return UDim2.fromScale(num1 or 0, 1)
end

local function getIndeterminateShimmerTransparency(n: number, reducedMotion: boolean, emphasisTransparency: number): NumberSequence
    if reducedMotion then
        return NumberSequence.new(n)
    end

    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.2, 1),
        NumberSequenceKeypoint.new(0.5, emphasisTransparency),
        NumberSequenceKeypoint.new(0.8, 1),
        NumberSequenceKeypoint.new(1, 1)
    })
end

local function getIndeterminateShimmerOffset(num1: number, reducedMotion: boolean): Vector2
    if reducedMotion then
        return Vector2.new(0, 0)
    end

    return Vector2.new(num1 * constants.INDETERMINATE_SHIMMER_SPEED % 360 / 360 * 2 - 1, 0)
end

local function ProgressBarIndeterminateGradient(tbl1)
    local var1 = useRotation(1)
    local var2 = usePulseBinding(1 / constants.INDETERMINATE_SHIMMER_SPEED)

    return React.createElement("UIGradient", {
        Color = ColorSequence.new(tbl1.emphasisColor3),
        Transparency = var2:map(function(n: number): NumberSequence
            return getIndeterminateShimmerTransparency(n, tbl1.reducedMotion, tbl1.emphasisTransparency)
        end),
        Offset = var1:map(function(num1: number): Vector2
            return getIndeterminateShimmerOffset(num1, tbl1.reducedMotion)
        end),
        [React.Tag] = getTestIdTag(tbl1.testId)
    })
end

local tbl1 = {
    size = ProgressSize.Medium,
    width = UDim.new(1, 0),
    showLabel = false,
    minValueLabel = "0",
    maxValueLabel = "100"
}

local function ProgressBar(arg1)
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = usePreferences()
    local var4 = useProgressVariants(var2, if var1.size == ProgressSize.Small then ProgressSize.Small else ProgressSize.Medium)

    local var5, var6 = useProgressBinding(var1.value)

    local createElement = React.createElement
    local var7 = View
    local var8 = withCommonProps(
        var1,
        {
            tag = "col gap-xsmall size-full-0 auto-y",
            Size = UDim2.new(var1.width, UDim.new(0, 0)),
            ref = var1.ref
        }
    )
    local tbl2 = { Track = 0, Labels = 0 }
    local createElement2 = React.createElement
    local var9 = View
    local tbl3 = {
        Size = UDim2.new(UDim.new(1, 0), UDim.new(0, var4.bar.height)),
        cornerRadius = UDim.new(0, var2.Radius.Circle),
        tag = "size-full-0 clip bg-shift-400",
        LayoutOrder = 1,
        testId = `{var1.testId}--track`
    }
    local tbl4 = {
        Fill = React.createElement(
            View,
            {
                backgroundStyle = var2.Color.Content.Emphasis,
                cornerRadius = UDim.new(0, var2.Radius.Circle),
                Size = if var6 then UDim2.fromScale(1, 1) else mapBindable(var5, getFillSizeFromProgress),
                tag = if var6 then "size-full" else nil,
                testId = `{var1.testId}--fill`
            },
            var6
                and {
                    Gradient = React.createElement(ProgressBarIndeterminateGradient, {
                        emphasisColor3 = var2.Color.Content.Emphasis.Color3,
                        emphasisTransparency = var2.Color.Content.Emphasis.Transparency,
                        reducedMotion = var3.reducedMotion,
                        testId = `{var1.testId}--fill--gradient`
                    })
                }
                or nil
        )
    }
    tbl2.Track = createElement2(var9, tbl3, tbl4)
    local element

    if var1.showLabel and not var6 then
        element = React.createElement(
            View,
            {
                tag = "row size-full-0 auto-y",
                LayoutOrder = 2,
                testId = `{var1.testId}--labels`
            },
            {
                MinValue = React.createElement(Text, {
                    Text = var1.minValueLabel,
                    tag = "fill auto-xy text-label-medium text-align-x-left content-default",
                    LayoutOrder = 1,
                    testId = `{var1.testId}--label-min`
                }),
                MaxValue = React.createElement(Text, {
                    Text = var1.maxValueLabel,
                    tag = "fill auto-xy text-label-medium text-align-x-right content-default",
                    LayoutOrder = 2,
                    testId = `{var1.testId}--label-max`
                })
            }
        )
    else
        element = nil
    end

    tbl2.Labels = element
    return createElement(var7, var8, tbl2)
end

return ProgressBar
